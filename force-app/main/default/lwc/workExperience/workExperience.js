import { LightningElement } from 'lwc';

export default class WorkExperience extends LightningElement {
    workExperiences = [{ id: 0, jobtitle: '', companyname: '', startdate: '', enddate: '' }];

    handleChangeNew(event) {
        const index = event.target.dataset.index;
        const field = event.target.dataset.field;
        this.workExperiences[index] = { ...this.workExperiences[index], [field]: event.target.value };
        this.workExperiences = [...this.workExperiences]; // Ensure reactivity
        this.dispatchData();
    }

    handleWorkExperience() {
        this.workExperiences = [...this.workExperiences, { id: this.workExperiences.length, jobtitle: '', companyname: '', startdate: '', enddate: '' }];
    }

    dispatchData() {
        this.dispatchEvent(new CustomEvent('updateworkexperience', { detail: this.workExperiences }));
    }
}