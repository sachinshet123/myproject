import { api, LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LDSDemo1 extends LightningElement {
    @api objectApiName;
    @api fields;
    @api recordId;

    fields = ['Name', 'Site'];
        handleSuccess(event) {
            const recordId = event.detail.id; // ✅ Get the record ID correctly
        
            const toastEvent = new ShowToastEvent({
                title: 'Success!',
                message: `Record created successfully. Record ID: ${recordId}`,
                variant: 'success' // Options: 'info', 'warning', 'error'
            });
        
            this.dispatchEvent(toastEvent);
        }
}