import { LightningElement } from 'lwc';

export default class ConditionalRenderingDemo extends LightningElement {
    name = 'Sachin Shrikant Shet';
    address = 'Bangalore, India';
    phone = '9880403878';
    email = 'sachinshet.123@gmail.com';
    age = null;

    handleAge(event) {
        this.age = event.target.value ? parseInt(event.target.value, 10) : null;
    }

    get isEligible() {
        return this.age !== null && this.age >= 18;
    }
}