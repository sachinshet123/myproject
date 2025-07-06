import { LightningElement, api } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Scenario19MyOwn extends LightningElement {
    @api account = ACCOUNT_OBJECT;
    @api fields = [ACCOUNT_NAME_FIELD, PHONE_FIELD];
    @api recordId;

    
    handleSuccess(event) {
        this.dispatchEvent(new ShowToastEvent({title : 'Success', message : 'Account created successfully', variant : 'success'}));
    }
    handleError(event) {
      let errMsg = event.detail.message;
      console.log(errMsg);
      this.dispatchEvent(new ShowToastEvent({title : 'Error', message : 'Error happened', variant : 'error'}));
    }
}