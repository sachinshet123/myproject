import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/fetchDataFromAccount.getAccountList';

export default class FetchAccountDataFromOrg extends LightningElement {
    accounts;
    error;

    @wire(getAccountList)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.accounts = undefined;
        }
    }
}