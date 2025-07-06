import { LightningElement } from 'lwc';
import squareArea, { circleArea, rectangleArea, myName, getTermOptions, calculateMonthlyPayment, goodMorning } from './practice1';
import { goodMorningFromUtils } from 'c/utils';

export default class Child extends LightningElement {
    arraykk = getTermOptions();
    
    /*renderedCallback() {
        console.log('Area of Circle is ' + circleArea(5));
        console.log('Area of Square is ' + squareArea(5));
        console.log('Area of Rectangle is ' + rectangleArea(10,10));
        console.log(myName);
        console.log(getTermOptions());
     
        console.log('the monthly payment is ' + calculateMonthlyPayment(10000,10,5));
        console.log(window.alert('Good Morning'));
        goodMorning();
        goodMorningFromUtils();
    }*/
}