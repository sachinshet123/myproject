import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import CONTACT_OBJECT from '@salesforce/schema/Contact';

import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import ACCOUNTID_FIELD from '@salesforce/schema/Contact.AccountId';


export default class AccountContactCreator extends LightningElement {
    account = ACCOUNT_OBJECT;
    contact = CONTACT_OBJECT;
    accountId = '';
    showAccountForm = true;
    
    accountFields = [ACCOUNT_NAME_FIELD, PHONE_FIELD];
    contactFields = [FIRSTNAME_FIELD, LASTNAME_FIELD];

    handleAccountSuccess(event) {
        this.accountId = event.detail.id;
        this.showAccountForm = false;
        this.toastMessage('Success', 'account created successfully', 'success');
    }

    handleContactSubmit(event) {
        event.preventDefault();
        const fields = event.detail.fields;
        fields[ACCOUNTID_FIELD.fieldApiName] = this.accountId;
        this.template.querySelector('lightning-record-form').submit(fields);
    }

    handleContactSuccess(event) {
        this.toastMessage('Success', 'contact created successfully', 'success');
    }

    toastMessage(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({title, message,variant}));
    }
}