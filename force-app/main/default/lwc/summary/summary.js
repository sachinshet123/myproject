import { LightningElement } from 'lwc';

export default class Summary extends LightningElement {
    summary = '';

    handleSummaryChange(event) {
        this.summary = event.target.value;
        this.dispatchEvent(new CustomEvent('updatesummary', { detail: this.summary }));
    }
}