import { LightningElement } from 'lwc';

export default class ParentMessage10 extends LightningElement {
    handleClick() {
        this.template.querySelector('c-child-message10').changeMessage();
    }
}