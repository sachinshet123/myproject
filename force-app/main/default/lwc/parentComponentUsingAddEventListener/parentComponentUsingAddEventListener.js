import { LightningElement } from 'lwc';

export default class ParentComponentUsingAddEventListener extends LightningElement {
    messageFromChild = '';

    connectedCallback() {
        // Adding event listener to listen for the "messageupdate" event from child
        this.template.addEventListener('messageupdate', this.handleMessageUpdate.bind(this));
    }

    handleMessageUpdate(event) {
        this.messageFromChild = event.detail;
    }
}