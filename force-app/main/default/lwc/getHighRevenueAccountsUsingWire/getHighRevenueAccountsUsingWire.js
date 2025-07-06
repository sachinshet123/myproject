import { LightningElement, wire } from 'lwc';
import getHighRevenueAccount from '@salesforce/apex/AccountController.getHighRevenueAccount';

export default class GetHighRevenueAccountsUsingWire extends LightningElement {
    accountToDisplay = [];
    @wire(getHighRevenueAccount)
    accounts(response) {
        const {data, error} = response;
        if(error) {
            console.error(error);
            return;
        } 
        if(data) {
            this.accountToDisplay = data;
        }
    }
}