import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';

import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';


export default class MyCreateRecordUsingLDS extends LightningElement {
    accRecord = {
        Name : '',
        Phone : ''
    };

    handleNameChange(event) {
            this.accRecord.Name = event.target.value;
    }

    handlePhoneChange(event) {
        this.accRecord.Phone = event.target.value;
    }
    handleCreate() {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.accRecord.Name;
        fields[PHONE_FIELD.fieldApiName] = this.accRecord.Phone;

        const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };

        createRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account Created',
                        variant: 'success'}));
            })
            .catch(error => {
                alert('Error creating record');
                console.log(JSON.stringify(error));
            });



            

    }
}