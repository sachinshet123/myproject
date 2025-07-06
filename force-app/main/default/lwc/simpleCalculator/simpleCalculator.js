import { LightningElement } from 'lwc';

export default class SimpleCalculator extends LightningElement {
    number1 = '';
    number2 = '';
    selectedOperator = '+';
    result = '';
    operatorOptions =[{ label : 'Addition', value : '+'},
        { label : 'Subtraction', value : '-'},{ label : 'Multiplication', value :'*'}, 
        { label : 'Division', value :'/'}];

    handleNumber1Change(event) {
        this.number1 = event.target.value;
    }

    handleNumber2Change(event) {
        this.number2 = event.target.value;
    }

    handleOperationChange(event) {
        this.selectedOperator = event.target.value;
    }

    handleCalculate() {
        let num1 = parseFloat(this.number1);
        let num2 = parseFloat(this.number2);
        if(isNaN(num1) || isNaN(num2)) {
            this.result = 'Please enter valid numbers';
        }
        if(this.selectedOperator == '+') {
            this.result = num1 + num2;
        } else if(this.selectedOperator == '-') {
            this.result = num1 - num2;

        } else if(this.selectedOperator == '*') {
            this.result = num1 * num2;

        } else if(this.selectedOperator == '/') {
            this.result = num1 / num2;
        }
    }
}