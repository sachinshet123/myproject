import { LightningElement } from 'lwc';

export default class EducationDetail extends LightningElement {
    educations = [{ id: 0, degree: '', institution: '', year: '' }];

    handleEduChange(event) {
        const index = event.target.dataset.index;
        const field = event.target.dataset.field;
        this.educations[index] = { ...this.educations[index], [field]: event.target.value };
        this.educations = [...this.educations]; // Ensure reactivity
        this.dispatchData();
    }

    handleAdd() {
        this.educations = [...this.educations, { id: this.educations.length, degree: '', institution: '', year: '' }];
    }

    dispatchData() {
        this.dispatchEvent(new CustomEvent('updateeducation', { detail: this.educations }));
    }
}