import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

// Import Schema fields
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import CONTACT_FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import CONTACT_LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';

export default class Scenario18ChatGPT extends LightningElement {
    @track accountId;
    @track showAccountForm = true;

    accountFields = [ACCOUNT_NAME_FIELD, PHONE_FIELD];
    contactFields = [CONTACT_FIRSTNAME_FIELD, CONTACT_LASTNAME_FIELD];

    // Handle Account creation success
    handleAccountSuccess(event) {
        this.accountId = event.detail.id; // ✅ Store newly created Account ID
        this.showAccountForm = false;
        this.showToast('Success', 'Account created successfully!', 'success');
    }

    // Handle Contact creation success
    handleContactSuccess() {
        this.showToast('Success', 'Contact created and linked to Account!', 'success');
    }

    // Handle Errors
    handleError(event) {
        let errorMsg = event.detail.message || 'An unexpected error occurred!';
        this.showToast('Error', errorMsg, 'error');
    }

    // Show Toast Notifications
    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}