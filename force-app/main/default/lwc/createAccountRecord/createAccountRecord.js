import { api, LightningElement } from 'lwc';

export default class CreateAccountRecord extends LightningElement {
    @api objectApiName;
    @api recordId;
    accfields = [ 'Name', 'Phone', 'Type', 'Industry', 'FirstName', 'LastName', 'MobilePhone', 'Title', 'Priority', 'CaseNumber', 'Subject', '	Status', 
        'Name', 'CloseDate', 'StageName'];
}