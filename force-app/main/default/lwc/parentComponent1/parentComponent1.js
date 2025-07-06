import { LightningElement } from 'lwc';

export default class ParentComponent1 extends LightningElement {
    handleUpdate() {
        this.template.querySelector('c-child-component').changeMessage("Message Updated from Parent!");
    }
}