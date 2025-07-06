import { LightningElement } from 'lwc';

export default class ResumeBuilder extends LightningElement {
    personalInformation = {};
    educations = [];
    workExperiences = [];
    skills = [];
    summary = '';
    
    
    handleUpdateResume(event) {
        console.log(event.detail);
        console.log('from parent update resume');
        this.personalInformation = event.detail;
    }

    handleUpdateEducation(event) {
        console.log(event.detail);
        console.log('from parent update education');
        this.educations = event.detail;
    }

    handleWorkExperiences(event) {
        console.log(event.detail);
        console.log('from parent update work experience');
        this.workExperiences = event.detail;
    }

    handleSkill(event) {
        console.log(event.detail);
        console.log('from parent');
        this.skills = event.detail;
    }

    handleSummary(event) {
        console.log(event.detail);
        console.log('from parent summary');
        this.summary = event.detail;
    }
}