import { api, LightningElement } from 'lwc';

export default class OpportunityDemo extends LightningElement {
    @api fields;
    @api recordId;

    fields = ['Name', 'Phone', 'Amount', 'StageName', 'CloseDate'];
}