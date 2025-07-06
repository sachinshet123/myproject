import { LightningElement } from 'lwc';

export default class CustomEventDemoChild extends LightningElement {
    readMessage = '';
    handleClick() {
        const selectedEvent = new CustomEvent('custommessage', {
            detail: 'This is a demo'
        });
        this.dispatchEvent(selectedEvent);
        console.log('dispatchEvent called');
    }
    handleChange(event) {
        this.readMessage = event.target.value;
        const selectedEvent1 = new CustomEvent('custommessage1', {
            detail: this.readMessage
        });
        this.dispatchEvent(selectedEvent1);
    }
}