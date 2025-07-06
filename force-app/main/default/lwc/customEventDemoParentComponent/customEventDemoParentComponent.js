import { LightningElement } from 'lwc';

export default class CustomEventDemoParentComponent extends LightningElement {
    receiveMessage = '';
    receiveMessage1 = '';
    handleMessage(event) {
        this.receiveMessage = event.detail;
        console.log('parent method called');
    }

    handleMessage1(event) {
        this.receiveMessage1 = event.detail;
    }

}