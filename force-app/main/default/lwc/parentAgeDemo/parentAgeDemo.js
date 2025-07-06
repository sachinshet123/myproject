import { LightningElement } from 'lwc';

export default class ParentAgeDemo extends LightningElement {
    age = null;
    message = '';
    handleChangeValue(event) {
        this.age = event.target.value;
        if(event.target.value >= 18) {
            this.message = 'You are eligible to vote';
        }
        else {
            this.message = 'You are a senior citizen';
        }
    }
}