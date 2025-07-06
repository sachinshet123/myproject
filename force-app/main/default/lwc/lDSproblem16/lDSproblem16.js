import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import ACCOUNT_NUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';
import ACCOUNT_TYPE_FIELD from '@salesforce/schema/Account.Type';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ACCOUNT_INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LDSproblem16 extends LightningElement {
    //@api recordId;
    @api objectApiName;
    @api fields;
    fields = [NAME_FIELD, RATING_FIELD, ACCOUNT_NUMBER_FIELD, ACCOUNT_TYPE_FIELD, PHONE_FIELD, ACCOUNT_INDUSTRY_FIELD];

    handleSuccess(event) {
        const recordId = event.detail.id; // ✅ Get the record ID correctly
                
                    const toastEvent = new ShowToastEvent({
                        title: 'Success!',
                        message: `Record created successfully. Record ID: ${recordId}`,
                        variant: 'success' // Options: 'info', 'warning', 'error'
                    });
                    
                    this.dispatchEvent(toastEvent);
                    setTimeout(() => {
                        window.open(`/lightning/r/Account/${recordId}/view`, '_blank');
                    }, 2000);
                }
                
}