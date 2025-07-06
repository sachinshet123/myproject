import { LightningElement, api } from 'lwc';

export default class ChildMessage extends LightningElement {
    @api message = "Initial Message"; // Exposed property

    @api updateMessage(newMsg) {
        this.message = newMsg;
    }
}