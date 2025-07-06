import { LightningElement } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class DisplayMyName extends LightningElement {
    name = "Your Name Here"; // Change to your name

    closeAction() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }
}