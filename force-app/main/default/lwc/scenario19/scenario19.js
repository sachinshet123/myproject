import { LightningElement, api } from 'lwc';

export default class Scenario19 extends LightningElement {
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