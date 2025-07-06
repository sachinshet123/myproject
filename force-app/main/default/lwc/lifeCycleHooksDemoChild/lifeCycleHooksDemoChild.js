import { LightningElement } from 'lwc';

export default class LifeCycleHooksDemoChild extends LightningElement {
    constructor() {
        super();
        console.log('🚀 child constructor');
    }

    connectedCallback() {
        throw new Error('whoops');
    }
    
    //connectedCallback() {
     //   console.log('✅ child connectedCallback');
    //}

    renderedCallback() {
        console.log('🔄 child renderedCallback ');
    }

    handleIncrement() {
        console.log('child handleIncrement');
    }

    disconnectedCallback() {
        console.log('child disnconnectedCallback');
    }
}