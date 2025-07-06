import { LightningElement } from 'lwc';

export default class ParentCustomEventComponent extends LightningElement {
    messageFromChild = '';
    handleOnSelected(event) {
        this.messageFromChild = event.detail;
        console.log('The message received from child is : ' + event.detail);
    }
}