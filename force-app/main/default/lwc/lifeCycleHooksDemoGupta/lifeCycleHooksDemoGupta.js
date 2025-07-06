import { LightningElement } from 'lwc';

export default class LifeCycleHooksDemoGupta extends LightningElement {
    test;
    name = 'Car';
    price = '27000';
    ready = false;

    constructor() {
        super();
        this.test = 'component instance is created';
    }

    connectedCallback() {
        setTimeout(() => {
            this.ready = true;
        }, 3000);
    }
    renderedCallback() {
        this.ready = true;
    }
}