import { LightningElement } from 'lwc';

export default class CustomEventDemoParent extends LightningElement {
    displayMessage = '';
    displayMessage1 = '';
    handleCustomEventDemo(event) {
        this.displayMessage = event.detail;
        console.log('parent method is called');
    }

    handleCustomEventDemo1(event) {
        this.displayMessage1 = event.detail;
    }
}