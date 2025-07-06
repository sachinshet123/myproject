import { LightningElement } from 'lwc';

export default class BooleanParent extends LightningElement {
    
    constructor() {
        super();
        console.log('constructor on parent is called');
    }

    connectedCallback() {
        console.log('connected call back on the parent is called');
    }

    renderedCallback() {
        console.log('rendered call back on the parent is called');
    }

    disconnectedCallback() {
        console.log('disconnected call back on the parent is called');
    }
}