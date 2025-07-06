import { LightningElement } from 'lwc';

export default class ConditionalVisibility extends LightningElement {
    toggle = true;
    handleClick(event) {
        if(this.toggle) {
            this.toggle = false;
        } else {
            this.toggle = true;
        }
    }
}