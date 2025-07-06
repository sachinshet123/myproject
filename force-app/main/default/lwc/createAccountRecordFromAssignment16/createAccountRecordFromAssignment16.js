import { LightningElement,api } from 'lwc';


import { NavigationMixin } from 'lightning/navigation';


import ACCOUNT_OBJECT from "@salesforce/schema/Account";


import NAME_FIELD from "@salesforce/schema/Account.Name";
import WEBSITE_FIELD from "@salesforce/schema/Account.Website";
import ANNUALREVENUE_FIELD from "@salesforce/schema/Account.AnnualRevenue";
import FAX_FIELD from "@salesforce/schema/Account.Fax";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";


export default class CreateAccountRecordFromAssignment16 extends NavigationMixin(LightningElement) {
    @api recordId; //it is used to store recordId
    account=ACCOUNT_OBJECT;
    accfields=[NAME_FIELD,WEBSITE_FIELD,ANNUALREVENUE_FIELD,FAX_FIELD,INDUSTRY_FIELD];


redirecttoAccount(event){
    //this is used to navigate to newly created record
    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: event.detail.id,
            actionName: 'view'
        }
    });
}
}