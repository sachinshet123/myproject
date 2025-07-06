import { LightningElement, wire } from 'lwc';
// import uiRecordApi to create record
import { createRecord } from 'lightning/uiRecordApi';
// importing to show toast notifications
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// importing Account fields
import { NavigationMixin } from 'lightning/navigation';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import Phone_FIELD from '@salesforce/schema/Account.Phone';
import Industry_FIELD from '@salesforce/schema/Account.Industry'; // Correct field import
import Type_FIELD from '@salesforce/schema/Account.Type';

import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';

export default class Scenario20 extends NavigationMixin(LightningElement) {
   error;

   // this object has record information
   accRecord = {
       Name: '',
       Industry: '',
       Phone: '',
       Type: ''
   };

   handleNameChange(event) {
       this.accRecord.Name = event.target.value;
   }

   handlePhoneChange(event) {
       this.accRecord.Phone = event.target.value;
   }

   handleTypeChange(event) {
       this.accRecord.Type = event.target.value;
   }

   handleIndustryChange(event) {
       this.accRecord.Industry = event.target.value;
   }

   @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
   objectInfo({ data, error }) {
       if (data) {
           this.recordTypeId = data.defaultRecordTypeId;
       }
   }

   // Fetch Picklist Values for Industry Field (use correct field reference here)
   @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: Industry_FIELD }) // Corrected reference
   industryPicklistValues({ data, error }) {
       if (data) {
           this.industryOptions = data.values.map(item => ({ label: item.label, value: item.value }));
       }
   }

   handleSave(event) {
       const fields = {};
       fields[NAME_FIELD.fieldApiName] = this.accRecord.Name;
       fields[Phone_FIELD.fieldApiName] = this.accRecord.Phone;
       fields[Industry_FIELD.fieldApiName] = this.accRecord.Industry;
       fields[Type_FIELD.fieldApiName] = this.accRecord.Type;

       // Creating record using uiRecordApi
       const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };

       createRecord(recordInput)
           .then(result => {
               // Clear the user-entered values
               this.accRecord = {
                   Name: '',
                   Phone: '',
                   Industry: '',
                   Type: ''
               };

               // Show success message
               this.dispatchEvent(new ShowToastEvent({
                   title: 'Success!',
                   message: 'Account created successfully!',
                   variant: 'success'
               }));

               // Navigate to the newly created record page
               this[NavigationMixin.Navigate]({
                   type: 'standard__recordPage',
                   attributes: {
                       recordId: result.id,
                       objectApiName: ACCOUNT_OBJECT.objectApiName,
                       actionName: 'view'
                   }
               });
           })
           .catch(error => {
               this.error = JSON.stringify(error);
               this.dispatchEvent(new ShowToastEvent({
                   title: 'Error!',
                   message: this.error,
                   variant: 'error'
               }));
           });
   }
}