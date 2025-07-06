import { LightningElement } from 'lwc';

export default class CurrencyConverter extends LightningElement {
    euro = '';
    dollar = '';
    lastUpdated = '';
    handleEuroChange(event) {
        this.euro = event.target.value;
        this.lastUpdated = 'euro';
    }

    handleDollarChange(event) {
        this.dollar = event.target.value;
        this.lastUpdated = 'dollar';
    }

    viceVersaConverter() {
        if(this.lastUpdated == 'euro') {
            this.dollar = this.euro * 1.12;
        } else {
            this.euro = this.dollar * 0.9;
        }
    }
}