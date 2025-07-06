import { LightningElement } from 'lwc';

export default class LifeCycleHookChild extends LightningElement {
    constructor() {
        super();
        console.log('from child component');
    }


    connectedCallback() {
        console.log('from child connected callback');
    }


    renderedCallback() {
        console.log('from child rendered callback');
    }


    errorCallback() {
        console.log('error in child component');
    }

    
    disconnectedCallback() {
        console.log('from child disconnectd callback');
    }
}