import { LightningElement, track, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { createRecord } from 'lightning/uiRecordApi';


export default class GenericObjectListScenario17 extends NavigationMixin(LightningElement) {
    @track selectedObject;
    @track fieldsCollection = [];
    @track objectFields = {
        Account: ['Name', 'Industry', 'Type'],
        Contact: ['FirstName', 'LastName', 'Email'],
        Opportunity: ['Name', 'StageName', 'CloseDate'],
        Case: ['Status', 'Origin', 'Subject']
    };


    ObjectOptions = [
        { label: 'Account', value: 'Account' },
        { label: 'Contact', value: 'Contact' },
        { label: 'Case', value: 'Case' },
        { label: 'Opportunity', value: 'Opportunity' }
    ];


    ObjectChange(event) {
        this.selectedObject = event.detail.value;
        this.fieldsCollection = this.objectFields[this.selectedObject] || [];
    }


    handleSave() {
        const fields = {};
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            fields[element.fieldName] = element.value;
        });


        const recordInput = { apiName: this.selectedObject, fields };


        createRecord(recordInput)
            .then(record => {
                this.navigateToRecordPage(record.id);
            })
            .catch(error => {
                console.error('Error creating record:', error.body.message);
            });
    }


    navigateToRecordPage(recordId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                actionName: 'view'
            }
        });
    }
}