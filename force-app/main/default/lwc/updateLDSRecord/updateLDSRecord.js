import { LightningElement, api } from 'lwc';
import ACCOUNT_OBJECT from "@salesforce/schema/Account";

import { updateRecord } from 'lightning/uiRecordApi';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import ID_FIELD from '@salesforce/schema/Account.Id';





export default class UpdateLDSRecord extends LightningElement {
    @api recordId;
    Name = '';
    Phone = '';
    Industry = '';
    Rating = '';


    handleChange(event) {
        if(event.target.name == 'Account Name') {
            this.Name = event.target.value;
        } else if (event.target.name == 'Phone') {
            this.Phone = event.target.value;
        } else if (event.target.name == 'Industry') {
            this.Industry = event.target.value;
        } else if (event.target.name == 'Rating') {
            this.Rating = event.target.value;
        }
    }
    handleUpdate() {
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[ACCOUNT_NAME_FIELD.fieldApiName] = this.Name;  
        fields[PHONE_FIELD.fieldApiName] = this.Phone;
        fields[INDUSTRY_FIELD.fieldApiName] = this.Industry;
        fields[RATING_FIELD.fieldApiName] = this.Rating;
        const recordInput = { fields };




        updateRecord(recordInput)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account Updated',
                    variant: 'success'
                })
            );
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating record',
                    message: error.body ? error.body.message : 'Unknown error',
                    variant: 'error'
                })
            );
        }); // 🔹 Correctly closing the `.catch()` block
      }
    }