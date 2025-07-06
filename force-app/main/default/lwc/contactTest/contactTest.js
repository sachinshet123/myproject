import { api, LightningElement } from 'lwc';
import HOME_PHONE_FIELD from '@salesforce/schema/Contact.HomePhone';
import ASSISTANT_FIELD from '@salesforce/schema/Contact.AssistantName';

export default class ContactTest extends LightningElement {
    @api objectApiName;
    @api recordId;
    @api fields;
    fields = [HOME_PHONE_FIELD, ASSISTANT_FIELD];
}