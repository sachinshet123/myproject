import { LightningElement,api,track,wire } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';
//Use this wire adapter to get RelatedList records.
import { getFieldValue } from 'lightning/uiRecordApi';
//getFieldValue: It allows you to retrieve the value of a field from a record without needing to handle null checks or navigate nested objects manually.
export default class Scenario38 extends LightningElement {
  @api recordId;
  Records =[];
  reletedRecords;
  columns = [
       
    { label: 'First Name', fieldName: 'FirstName', editable: false },
    { label: 'Last Name', fieldName: 'LastName', editable: false },
    { label: 'Email', fieldName: 'Email', type: 'email', editable: false },
    { label: 'Title', fieldName: 'Title', type: 'text', editable: false }
];
@wire(getRelatedListRecords, {
    parentRecordId: '$recordId',
    relatedListId: 'Contacts',
    fields: ['Contact.Id','Contact.FirstName','Contact.LastName','Contact.Email','Contact.Title'],
    sortBy: ['Contact.FirstName']
})
wiredRecords({data, error}){
    //console.log(recordId);
    if (data) {
        this.Records = data.records.map(record=>({
            Id:getFieldValue(record,'Contact.Id'),
            FirstName:getFieldValue(record,'Contact.FirstName'),
            LastName:getFieldValue(record,'Contact.LastName'),
            Email:getFieldValue(record,'Contact.Email'),
            Title:getFieldValue(record,'Contact.Title')
        }));


    }
    if (error) {
        console.error('Error occurred retrieving records...');
    }
}
}