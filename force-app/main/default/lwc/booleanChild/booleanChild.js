import { LightningElement, api } from 'lwc';

export default class BooleanChild extends LightningElement {
    @api show = false;

    constructor() {
        super();
        console.log('constructor on child is called');
    }

    connectedCallback() {
        console.log('connected call back on the child is called');
    }

    renderedCallback() {
        console.log('rendered call back on the child is called');
    }

    disconnectedCallback() {
        console.log('disconnected call back on the child is called');
    }
}