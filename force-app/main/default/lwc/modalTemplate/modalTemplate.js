import { LightningElement, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ModalTemplate extends LightningElement {
    @track isModalOpen = false;
    accountName = '';

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    handleNameChange(event) {
        this.accountName = event.target.value;
    }

    handleSave() {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.accountName;

        const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };

        createRecord(recordInput)
            .then((account) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account created successfully',
                        variant: 'success'
                    })
                );
                this.closeModal();
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating account',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}