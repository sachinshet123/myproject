import { LightningElement } from 'lwc';

export default class PersonalInfo extends LightningElement {
    personalInformation = {
        fullName: '',
        email: '',
        phone: '',
        address: ''
    };

    handlePIChange(event) {
        const fieldName = event.target.dataset.field;
        this.personalInformation = { ...this.personalInformation, [fieldName]: event.target.value };
        this.dispatchEvent(new CustomEvent('updateresume', { detail: this.personalInformation }));
    }
}