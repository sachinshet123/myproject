import { api, LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import CONTACT_LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import CONTACT_PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import CONTACT_ACCOUNTID_FIELD from '@salesforce/schema/Contact.AccountId';


export default class CreateContactThroughAccountMyOwn extends LightningElement {
    @api recordId;
    lastName = '';
    phone = '';
    accountId = '';

    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }

    handlePhoneChange(event) {
        this.phone = event.target.value;
    }

    handleSubmit() {
        const fields = {};
        fields[CONTACT_LASTNAME_FIELD.fieldApiName] = this.lastName;
        fields[CONTACT_PHONE_FIELD.fieldApiName] = this.phone;
        fields[CONTACT_ACCOUNTID_FIELD.fieldApiName] = this.recordId;

        const recordInput = { apiName: CONTACT_OBJECT.objectApiName, fields };

        createRecord(recordInput)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact created successfully',
                    variant: 'success'
                })
            );
    })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error'
                })
            )});
        }
        
}