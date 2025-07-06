import { LightningElement, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';

export default class AccountRecordThroughLDS extends LightningElement {
     recordId = '001dL00000t2btSQAQ'; // Stores user-inputted Record ID
     accountName; // Stores fetched Account Name
     error; // Stores any errors

    // Wire Adapter to Fetch Account Record
    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME] })
    wiredAccount({ error, data }) {
        if (data) {
            this.accountName = data.fields.Name.value;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.accountName = undefined;
        }
    }

    // Handle User Input Change
    handleInputChange(event) {
        this.recordId = event.target.value;
    }
}