import { LightningElement } from 'lwc';

export default class PreviewPersonalInfo extends LightningElement {
    personalInfo = {}; // Object to store received data

    handlePersonalInfo(event) {
        this.personalInfo = { ...event.detail }; // Ensure reactivity
        console.log('Received Personal Info:', this.personalInfo);
    }
}