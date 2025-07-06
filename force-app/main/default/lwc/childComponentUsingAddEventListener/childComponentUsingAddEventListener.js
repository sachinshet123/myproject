import { LightningElement } from 'lwc';

export default class ChildComponentUsingAddEventListener extends LightningElement {
    message = '';

    handleInputChange(event) {
        this.message = event.target.value;
        
        // Dispatching a custom event with the input value
        const customEvent = new CustomEvent('messageupdate', {
            detail: this.message,
            bubbles: true,
            composed: true // Ensures it escapes Shadow DOM
        });

        this.dispatchEvent(customEvent);
    }
}