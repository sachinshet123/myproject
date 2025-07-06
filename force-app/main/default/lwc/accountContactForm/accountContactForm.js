import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

// Import Schema fields
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import CONTACT_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import ACCOUNT_ID_FIELD from '@salesforce/schema/Contact.AccountId';

export default class AccountContactForm extends LightningElement {
    @track showContactForm = false;
    @track accountId = '';

    // Define Account & Contact Fields
    accountFields = [ACCOUNT_NAME_FIELD, PHONE_FIELD];
    contactFields = [CONTACT_NAME_FIELD, ACCOUNT_ID_FIELD];

    // Handle Account Creation Success
    handleAccountSuccess(event) {
        this.accountId = event.detail.id; // Store new Account ID
        this.showContactForm = true; // Show Contact form

        this.showToast('Success', 'Account created successfully!', 'success');
        console.log('Account Created with ID:', this.accountId);
    }

    // Handle Contact Creation Success
    handleContactSuccess(event) {
        this.showToast('Success', 'Contact created and linked to Account!', 'success');
        console.log('Contact Created with ID:', event.detail.id);
    }

    // Handle Error
    handleError(event) {
        let errorMsg = event.detail.message || 'An error occurred!';
        this.showToast('Error', errorMsg, 'error');
        console.error('Error:', errorMsg);
    }

    // Show Toast Messages
    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}