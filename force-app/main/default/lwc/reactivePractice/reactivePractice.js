import { LightningElement, track } from 'lwc';

export default class ReactivePractice extends LightningElement {
    //@track personalDetails = [{ name : 'Mahesh', age : 30 }, { name : 'Ganesh', age : 35 }];
    @track personalDetails = [];
    fruits = ['Apple', 'Orange', 'Mango', 'Papaya', 'Peach'];
    name = '';
    age = '';
    handleNameChange(event) {
        this.name = event.target.value;
    }

    handleAgeChange(event) {
        this.age = event.target.value;
    }

    addPerson() {
        this.personalDetails.push({ name : this.name, age : this.age });
    }
}