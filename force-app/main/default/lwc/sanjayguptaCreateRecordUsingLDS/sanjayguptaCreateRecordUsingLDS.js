import { LightningElement, api } from 'lwc';
// import uiRecordApi to create record
import { createRecord } from 'lightning/uiRecordApi';
// importing to show toast notifications
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
// importing Account fields
import { NavigationMixin } from 'lightning/navigation';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import Phone_FIELD from '@salesforce/schema/Account.Phone';
import Industry_FIELD from '@salesforce/schema/Account.Industry';
import Type_FIELD from '@salesforce/schema/Account.Type';


export default class SanjayguptaCreateRecordUsingLDS extends NavigationMixin(LightningElement) {
   @api recordId;
   error;
   // this object have record information
   accRecord = {
       Name : NAME_FIELD,
       Industry : Industry_FIELD,
       Phone : Phone_FIELD,
       Type : Type_FIELD
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
   handleSave(event) {
       const fields = {};


       fields[NAME_FIELD.fieldApiName] = this.accRecord.Name;
       fields[Phone_FIELD.fieldApiName] = this.accRecord.Phone;
       fields[Industry_FIELD.fieldApiName] = this.accRecord.Industry;
       fields[Type_FIELD.fieldApiName] = this.accRecord.Type;
     
       // Creating record using uiRecordApi
       let recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields }
       createRecord(recordInput)
       .then(result => {
           // Clear the user enter values
           this.accRecord = {};
           // Show success message
           this.dispatchEvent(new ShowToastEvent({
               title: 'Success!!',
               message: 'Account Created Successfully!!',
               variant: 'success'
               }),
           );
           this[NavigationMixin.Navigate]({
               type: "standard__recordPage",
               attributes: {
                   recordId: result.id,
                   objectApiName: ACCOUNT_OBJECT.objectApiName,
                   actionName: 'view'
               }
             });
       })
       .catch(error => {
           this.error = JSON.stringify(error);
       });
   }
}