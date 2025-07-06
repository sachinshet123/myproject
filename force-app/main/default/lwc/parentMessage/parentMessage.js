import { LightningElement } from 'lwc';

export default class ParentMessage extends LightningElement {
    handleUpdate() {
        this.template.querySelector('c-child-message').updateMessage("Message Updated from Parent!");
    }
}