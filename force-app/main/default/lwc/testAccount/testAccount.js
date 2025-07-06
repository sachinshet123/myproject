import { api, LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

export default class TestAccount extends LightningElement {
    @api recordId;
    @api objectApiName = ACCOUNT_OBJECT;
    @api fields = [ACCOUNT_NAME_FIELD, PHONE_FIELD];
}