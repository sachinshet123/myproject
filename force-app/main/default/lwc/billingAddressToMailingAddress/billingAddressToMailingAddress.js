import { LightningElement, track } from 'lwc';

export default class billingAddressToMailingAddress extends LightningElement {
    billingAddress = '';
    mailingAddress = '';
    copyBillingToMailing() {
        this.mailingAddress = this.billingAddress;
    }
}