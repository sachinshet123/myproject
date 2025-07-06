import { LightningElement } from 'lwc';

export default class ChildCustomEventComponent extends LightningElement {

    handleClick(){
        // Fire the custom event
        const selectedEvent = new CustomEvent('selected', { bubbles: true, 
            composed: true, 
            detail: 'This is coming from Child'
        });
        this.dispatchEvent(selectedEvent);
    }
}