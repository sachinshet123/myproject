import { LightningElement } from 'lwc';

export default class ParentComponentNew extends LightningElement {
    messageFromChild = '';
    parentMessage = 'this is a message from parent';

    connectedCallback() {
        // Adding event listener to listen for the "messageupdate" event from child
        this.template.addEventListener('passmessage', this.handlCustomEventOnPassMessage.bind(this));
    }
    handlCustomEventOnPassMessage(event){
        this.messageFromChild = event.detail;
    }
}