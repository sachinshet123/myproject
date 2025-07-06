import { LightningElement } from 'lwc';

export default class BillingAddressToMailingAddressNew extends LightningElement {
    billingAddress = '';
    mailingAddress = '';

    copyAddress() {
        this.mailingAddress = this.billingAddress;
    }
    handleChange(event) {
        this.billingAddress = event.target.value;
    }
}