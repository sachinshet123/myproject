import { LightningElement, api } from 'lwc';
import ACCOUNT_OBJECT from "@salesforce/schema/Account";


import ID_FIELD from "@salesforce/schema/Account.Id";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import RATING_FIELD from "@salesforce/schema/Account.Rating";


// Import the named import updateRecord
import { updateRecord } from "lightning/uiRecordApi";
// importing to show toast notifictions
import {ShowToastEvent} from 'lightning/platformShowToastEvent';


export default class Scenario21SanjayGupta extends LightningElement {


   @api recordId;
    name;
   industry;
   rating;


 handleChange(e) {
   if (e.target.name === "name") {
     //this is name input textbox
     this.name = e.target.value;
   } else if (e.target.name === "industry") {
     //this is industry input textbox
     this.industry = e.target.value;
   } else if (e.target.name === "rating") {
     //this is rating input textbox
     this.rating = e.target.value;
   }
 }


 handleClick() {
     //map the data to the fields
   const fields = {};


   fields[ID_FIELD.fieldApiName] = this.recordId;
   fields[NAME_FIELD.fieldApiName] = this.name;
   fields[INDUSTRY_FIELD.fieldApiName] = this.industry;
   fields[RATING_FIELD.fieldApiName] = this.rating;
      
       //Create a config object that had info about fields.
       //Quick heads up here we are not providing Object API Name
   const recordInput = {
     fields: fields
   };


       //Invoke the method updateRecord()
   updateRecord(recordInput)
   .then((record) => {
     // Show success messsage
     this.dispatchEvent(new ShowToastEvent({
       title: 'Success!!',
       message: 'Account Updated Successfully!!',
       variant: 'success'
       }),);
   });
 }
}