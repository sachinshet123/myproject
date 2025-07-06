import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class LightningRecordEditForm extends LightningElement {
    @api recordId;

    handleSuccess(event) {
        this.dispatchEvent(new ShowToastEvent({title : 'Success', message : 'Account updated successfully', variant : 'success'}));
    }

}