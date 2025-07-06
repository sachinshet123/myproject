import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    message = 'Parent';
    handleChange(event) {
        this.template.querySelector('c-child-component').convertToUpperCase(event.target.value);
    }
}