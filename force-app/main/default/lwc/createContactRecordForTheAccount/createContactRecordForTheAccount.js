import { api, LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';



export default class CreateContactRecordForTheAccount extends LightningElement {
    @api recordId;
}