import { LightningElement, track } from 'lwc';
import updateAllAccounts from '@salesforce/apex/AccountBatchUpdater.updateAllAccounts';


export default class Scenario35 extends LightningElement {
    showSuccessMessage = false;
    handleUpdate() {
        updateAllAccounts()
            .then(result => {
                this.showSuccessMessage = true;
            })
            .catch(error => {
                console.error('Error updating accounts', error);
            });
    }
}