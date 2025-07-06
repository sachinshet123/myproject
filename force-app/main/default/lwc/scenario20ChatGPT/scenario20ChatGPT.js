import { LightningElement, api, wire, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';

// Import Salesforce Schema
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import TYPE_FIELD from '@salesforce/schema/Account.Type';

export default class Scenario20ChatGPT extends NavigationMixin(LightningElement) {
    @api recordId;
    error = '';
    recordTypeId;
    @track industryOptions = [];
    @track typeOptions = [];

    // Holds user-entered account information
    accRecord = {
        Name: '',
        Industry: '',
        Phone: '',
        Type: ''
    };

    // Fetch Account Object Info to Get Record Type ID
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo({ data, error }) {
        if (data) {
            this.recordTypeId = data.defaultRecordTypeId;
        } else if (error) {
            this.error = 'Error fetching Account object info';
            console.error('Object Info Error:', error);
        }
    }

    // Fetch Picklist Values for Industry Field
    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: INDUSTRY_FIELD })
    industryPicklistValues({ data, error }) {
        if (data) {
            this.industryOptions = data.values.map(item => ({ label: item.label, value: item.value }));
        } else if (error) {
            this.industryError = 'Error fetching Industry picklist values';
            console.error('Industry Picklist Error:', error);
        }
    }

    // Fetch Picklist Values for Type Field
    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: TYPE_FIELD })
    typePicklistValues({ data, error }) {
        if (data) {
            this.typeOptions = data.values.map(item => ({ label: item.label, value: item.value }));
        } else if (error) {
            this.typeError = 'Error fetching Type picklist values';
            console.error('Type Picklist Error:', error);
        }
    }

    // Generic input handler
    handleInputChange(event) {
        const { name, value } = event.target;
        this.accRecord = { ...this.accRecord, [name]: value };
    }

    // Handles form submission and record creation
    handleSave() {
        const fields = {
            [NAME_FIELD.fieldApiName]: this.accRecord.Name,
            [PHONE_FIELD.fieldApiName]: this.accRecord.Phone,
            [INDUSTRY_FIELD.fieldApiName]: this.accRecord.Industry,
            [TYPE_FIELD.fieldApiName]: this.accRecord.Type
        };

        const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };

        createRecord(recordInput)
            .then(result => {
                this.accRecord = { Name: '', Industry: '', Phone: '', Type: '' };
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success!',
                    message: 'Account Created Successfully!',
                    variant: 'success'
                }));
                this[NavigationMixin.Navigate]({
                    type: "standard__recordPage",
                    attributes: {
                        recordId: result.id,
                        objectApiName: "Account",
                        actionName: "view"
                    }
                });
            })
            .catch(error => {
                this.error = error.body ? error.body.message : 'Error creating record';
            });
    }
}