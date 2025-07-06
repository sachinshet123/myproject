import { LightningElement } from 'lwc';
import getHighRevenueAccount from '@salesforce/apex/ImperativeApproachAccountController.getHighRevenueAccount';

export default class GetHighRevenueAccountImperativeApproach extends LightningElement {
    accountToDisplay = [];
    defaultRecords = 5;

    connectedCallback() {
        getHighRevenueAccount({count:this.defaultRecords}).then(response => {
            console.log('response using imperative approach');
            this.accountToDisplay = response;
        }).catch(error => {
            console.error(error);
        });
    }
    handleChange(event) {
        this.defaultRecords = event.target.value;
        getHighRevenueAccount({count:this.defaultRecords}).then(response => {
            console.log('response using imperative approach');
            this.accountToDisplay = response;
        }).catch(error => {
            console.error(error);
        });
    }
}