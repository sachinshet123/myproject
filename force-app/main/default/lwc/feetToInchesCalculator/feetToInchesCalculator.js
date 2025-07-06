import { LightningElement } from 'lwc';

export default class FeetToInchesCalculator extends LightningElement {
    feet = '';
    inches = '';

    handleChange(event) {
        this.feet = event.target.value;
        
    }

    copyFeetToInches() {
        this.inches = this.feet*12;
    }

}