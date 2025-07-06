import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController10.getAccounts';

const COLUMNS = [
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

export default class LightningDatatableDemo extends LightningElement {
    accounts;
    columns = COLUMNS;

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            console.error('Error fetching accounts:', error);
        }
    }
}