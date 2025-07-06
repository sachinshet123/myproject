import { LightningElement } from 'lwc';
export default class CreateAccountAndContactRecord extends LightningElement {
    accountId;
    showAccountForm = true;
    accountFields = ['Name','Phone'];
    contactFields = ['FirstName', 'LastName'];
    handleSuccess(event) {
        console.log(event.detail.id);
        this.accountId = event.detail.id;
        this.showAccountForm = false;
    }
     handleContactSubmit(event) {
        event.preventDefault(); // stop the form from submitting
        const fields = event.detail.fields;
        fields.AccountId = this.accountId // modify a field


//below statement forcefully submit the form               
this.template.querySelector('lightning-record-form').submit(fields);
    }
}