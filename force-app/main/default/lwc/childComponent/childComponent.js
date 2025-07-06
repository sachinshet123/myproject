import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api messageFor = '';
    @api messageFromParent = '';
    @api convertToUpperCase(message) {
        this.messageFromParent = message.toUpperCase();
    }
}