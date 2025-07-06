import { LightningElement } from 'lwc';

export default class LifeCycleHooksParent extends LightningElement {
    bool = true;
    constructor() {
        super();
        console.log('from parent component');
    }
    connectedCallback() {
        console.log('from parent connected callback');
    }
    renderedCallback() {
        console.log('from parent rendered callback');
    }

    disconnectedCallback() {
        console.log('from parent disconnectd callback');
    }

    handleClick() {
        this.bool = false;
    }
}