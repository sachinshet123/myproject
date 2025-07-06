import { LightningElement, api } from 'lwc';

export default class ChildAgeDemo extends LightningElement {
    @api ageFromParentForAge;
    @api messageFromParentForAge;
}