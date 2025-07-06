import { api, LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import ACCOUNTID_FIELD from '@salesforce/schema/Contact.AccountId';

export default class CreateContactRecordThroughAccount extends LightningElement {
    @api recordId;  // Account Id passed from the parent component or record page
    lastName = '';
    phone = '';

    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }

    handlePhoneChange(event) {
        this.phone = event.target.value;
    }

    handleSave() {
        if (!this.lastName) {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: 'Last Name is required!',
                variant: 'error'
            }));
            return;
        }

        const fields = {
            [LASTNAME_FIELD.fieldApiName]: this.lastName,
            [PHONE_FIELD.fieldApiName]: this.phone,
            [ACCOUNTID_FIELD.fieldApiName]: this.recordId
        };

        const recordInput = { apiName: CONTACT_OBJECT.objectApiName, fields };

        createRecord(recordInput)
            .then(contact => {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success',
                    message: `Contact created successfully! ID: ${contact.id}`,
                    variant: 'success'
                }));

                // Clear input fields
                this.lastName = '';
                this.phone = '';
            })
            .catch(error => {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error creating contact',
                    message: error.body?.message || 'Unknown error',
                    variant: 'error'
                }));
            });
    }
}