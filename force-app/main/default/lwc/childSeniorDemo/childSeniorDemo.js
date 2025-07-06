import { api, LightningElement } from 'lwc';

export default class ChildSeniorDemo extends LightningElement {
    @api ageFromParentForSenior;
    @api messageFromParentForSenior;

}