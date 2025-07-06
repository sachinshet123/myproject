import { LightningElement } from 'lwc';

export default class CustomEventDemoChildComponent extends LightningElement {
    readMessage = '';
    handleClick() {
        const messageEvent = new CustomEvent('custommessage', {
            detail: 'Hello from child123'
        });
        this.dispatchEvent(messageEvent);
    }

    handleNameChange(event) {
        this.readMessage = event.target.value;
        const messageEvent1 = new CustomEvent('custommessage1', {
            detail: this.readMessage
        });
        this.dispatchEvent(messageEvent1);
    }
}