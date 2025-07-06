import { LightningElement } from 'lwc';

export default class PercentageGradeCalculator extends LightningElement {
    sub1 = '';
    sub2 = '';
    sub3 = '';
    totalMarks = '';
    percentage = '';
    grade = '';
    
    handleNumber1Change(event) {
        this.sub1 = parseFloat(event.target.value);
    }
    handleNumber2Change(event) {
        this.sub2 = parseFloat(event.target.value);
    }
    handleNumber3Change(event) {
        this.sub3 = parseFloat(event.target.value);
    }
    handleTotalMarks() {
        console.log('1');
        if(isNaN(this.sub1) || isNaN(this.sub2) || isNaN(this.sub3)){
            this.totalMarks = 'Please enter valid numbers';
            return;
        }
        this.totalMarks = this.sub1 + this.sub2 + this.sub3;
        console.log('2');
    }
    handleCalculatePercentage() {
        if(isNaN(this.totalMarks)){
            this.percentage = 'Please enter valid numbers';
            return;
        }
        this.percentage = ((this.totalMarks/300)*100).toFixed(2);
        
    }
    handleCalculateGrade() {
        if(isNaN(this.percentage)){
            this.grade = 'Please enter valid numbers';
            return;
        }
        if(this.percentage > 90) {
            this.grade = 'Distinction';
        } else if(this.percentage > 75) {
            this.grade = 'First Class';
        } else if(this.percentage > 60) {
            this.grade = 'Second Pass';
        } else if(this.percentage > 35) {
            this.grade = 'Just Pass';
        } else {
            this.grade = 'Fail';
        }
    }
}