import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class OverrideStandardEditButtonWithLWC extends LightningElement {
    @api recordId;


    handleSubmit(event){
        console.log(this.recordId);
        //event.preventDefault();
        const evt = new ShowToastEvent({
            title: 'Account Updated',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
}