import { LightningElement } from 'lwc';

export default class LifeCycleHooksDemo extends LightningElement {
    count = 1; // This is already reactive in modern LWC
    isVisible = true;

    constructor() {
        super();
        console.log('🚀 parent constructor');
    }

    connectedCallback() {
        console.log('✅ parent connectedCallback');

        try {
            throw new Error('Error in Parent Component!');
        }

        catch (error) {
            console.error('Caught Error in Parent:', error.message);
        }
    }

    renderedCallback() {
        console.log('🔄 parent renderedCallback ' + this.count);
    }

    errorCallback(error, stack) {
        console.log('Child error callback called, error = ' + error + ', stack = ' + stack);
    }
    
    
    handleIncrement() {
        this.count++; // This now triggers re-render
    }
    handleShowCount() {
        alert(this.count);
    }
    handleShowChild() {
        this.isVisible = !this.isVisible;
    }
}