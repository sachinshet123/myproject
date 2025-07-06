import { LightningElement } from 'lwc';

export default class PracticeWebComponent extends LightningElement {
    // Updated contacts array as an array of objects
    contacts = [
        { id: 1, name: 'Sachin' },
        { id: 2, name: 'Suresh' },
        { id: 3, name: 'Rajesh' },
        { id: 4, name: 'Ramesh' },
        { id: 5, name: 'Sanket' }
    ];

    name = '';
    age = '';
    gender = '';
    email = '';
    phone = '';

    boolean = true;

    handleChangeName(event) {
        this.name = event.target.value;
    }

    handleChangeAge(event) {
        this.age = event.target.value;
    }

    handleChangeGender(event) {
        this.gender = event.target.value;
    }

    handleChangeEmail(event) {
        this.email = event.target.value;
    }

    handleChangePhone(event) {
        this.phone = event.target.value;
    }

    handleSubmit() {
        // Simple validation to check if all fields are filled
        if (!this.name || !this.age || !this.gender || !this.email || !this.phone) {
            alert('All fields are required!');
            return;
        }
        this.boolean = false;
    }
}