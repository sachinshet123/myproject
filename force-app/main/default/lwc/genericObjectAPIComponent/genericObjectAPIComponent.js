import { api, LightningElement } from 'lwc';

// Import Object API Name
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

// Import Fields from Schema
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_PHONE from '@salesforce/schema/Account.Phone';
import ACCOUNT_TYPE from '@salesforce/schema/Account.Type';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';

import OPPORTUNITY_NAME from '@salesforce/schema/Opportunity.Name';
import OPPORTUNITY_CLOSEDATE from '@salesforce/schema/Opportunity.CloseDate';
import OPPORTUNITY_STAGE from '@salesforce/schema/Opportunity.StageName';

export default class GenericObjectAPIComponent extends LightningElement {
    @api recordId;
    objectApiName = ACCOUNT_OBJECT; // Specify Object API Name (Account or Opportunity)

    // Define Fields Explicitly from Schema
    accfields = [ACCOUNT_NAME, ACCOUNT_PHONE, ACCOUNT_TYPE, ACCOUNT_INDUSTRY, OPPORTUNITY_NAME, OPPORTUNITY_CLOSEDATE, OPPORTUNITY_STAGE];
}