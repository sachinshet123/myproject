import { LightningElement, track } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ACCOUNT_NUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';
import ACCOUNT_SITE_FIELD from '@salesforce/schema/Account.Site';

import CONTACT_OBJECT from '@salesforce/schema/Contact';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import TITLE_FIELD from '@salesforce/schema/Contact.Title';
import DEPARTMENT_FIELD from '@salesforce/schema/Contact.Department';
import LEADSOURCE_FIELD from '@salesforce/schema/Contact.LeadSource';

import CASE_OBJECT from '@salesforce/schema/Case';
import STATUS_FIELD from '@salesforce/schema/Case.Status';
import ORIGIN_FIELD from '@salesforce/schema/Case.Origin';

import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';
import OPPORTUNITY_NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount';
import STAGENAME_FIELD from '@salesforce/schema/Opportunity.StageName';
import CLOSEDATE_FIELD from '@salesforce/schema/Opportunity.CloseDate';

export default class Scenario17 extends LightningElement {

    @track objectList = [{label : 'Account', value : 'Account'}, { label : 'Contact', value : 'Contact'}
        , { label : 'Case', value : 'Case'}, { label : 'Opportunity', value : 'Opportunity'}
    ];
    showData = false;
    objectName = '';
    selectedValue = '';
    fields = [];
    handleChange(event) {
        this.selectedValue = event.target.value;
        switch(this.selectedValue) {
            case 'Account':
                this.showData = true;
                this.objectName = ACCOUNT_OBJECT;
                this.fields = [NAME_FIELD, PHONE_FIELD, ACCOUNT_NUMBER_FIELD, ACCOUNT_SITE_FIELD];
                break;

            case 'Contact':
                this.showData = true;
                this.objectName = CONTACT_OBJECT;
                this.fields = [ LAST_NAME_FIELD, TITLE_FIELD, DEPARTMENT_FIELD, LEADSOURCE_FIELD];
                break;

            case 'Case':
                window.open(`/lightning/o/Case/new?count=1&nooverride=1&useRecordTypeCheck=1&navigationLocation=LIST_VIEW&uid=17428167409192146&backgroundContext=%2Flightning%2Fo%2FCase%2Flist%3FfilterName%3D__Recent`);
                this.showData = true;
                this.objectName = CASE_OBJECT;
                this.fields = [STATUS_FIELD, ORIGIN_FIELD];
                break;

            case 'Opportunity':
                this.showData = true;
                this.objectName = OPPORTUNITY_OBJECT;
                this.fields = [OPPORTUNITY_NAME_FIELD, AMOUNT_FIELD, CLOSEDATE_FIELD, STAGENAME_FIELD];
                break;
        }
    }
}