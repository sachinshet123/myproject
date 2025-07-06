import { LightningElement, api } from 'lwc';

export default class PreviewResume extends LightningElement {
    @api personalInformation;
    @api summary;
    @api skills;
    @api workExperiences;
    @api educations;
}