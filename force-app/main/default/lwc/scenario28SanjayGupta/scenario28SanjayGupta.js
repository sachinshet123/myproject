import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import WEBSITE_FIELD from "@salesforce/schema/Account.Website";
import ANNUALREVENUE_FIELD from "@salesforce/schema/Account.AnnualRevenue";
import FAX_FIELD from "@salesforce/schema/Account.Fax";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import { createRecord } from 'lightning/uiRecordApi';


export default class Scenario28SanjayGupta extends NavigationMixin(LightningElement)  {
    showContact=false;
   showCase=false;
   showOpp=false;
     showOption=false;
    caseSubject = '';
    contactFirstName = '';
     contactLastName = '';
    opportunityName = '';
    opportunityAmount = 0;
  
accountId;
    account=ACCOUNT_OBJECT;
    accfields=[NAME_FIELD,WEBSITE_FIELD,ANNUALREVENUE_FIELD,FAX_FIELD,INDUSTRY_FIELD];
    saveAccountandShowOption(event){
        this.showOption=true;
        this.showContact = false;
        this.showOpp = false;
        this.showCase = false;
        this.accountId = event.detail.id;
        console.log('Account created with Id:', this.accountId);
    }
    handleButtonClickContact(){
        this.showContact=true;
        this.showCase=false;
        this.showOpp=false;
    }
    handleButtonClickOpp(){
        this.showOpp=true;
        this.showContact=false;
        this.showCase=false;
    }
    handleButtonClickCase(){
        this.showCase=true;
        this.showOpp=false;
        this.showContact=false;
    }
    handleInputChange(event) {
        const { name, value } = event.target;
        this[name] = value;
        console.log("this[name]",event.target.name);
    }
    createCase() {
        this.createRecord('Case', {
            Subject: this.caseSubject,
            AccountId: this.accountId
        });
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.accountId,
                actionName: 'view'
            }
        });
    }
    createContact() {
        this.createRecord('Contact', {
            FirstName: this.contactFirstName,
            LastName: this.contactLastName,
            AccountId: this.accountId
        });
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.accountId,
                actionName: 'view'
            }
        });
    }
    createOpportunity() {
        this.createRecord('Opportunity', {
            Name: this.opportunityName,
            Amount: this.opportunityAmount,
            CloseDate: new Date(),
            StageName: 'Prospecting',
            AccountId: this.accountId
        });
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.accountId,
                actionName: 'view'
            }
        });
    }
    createRecord(objectApiName, fields) {
        //console.log(this.objectApiName);
        const recordInput = { apiName: objectApiName, fields };
        console.log("recordInput",recordInput);
        createRecord(recordInput)
            .then((record) => {
                console.log('${objectApiName} created with Id:', record.id);
                // You can add further logic or UI updates here
            })
            .catch((error) => {
                console.error('Error creating ${objectApiName}:', error.body.message);
            });
    }
}