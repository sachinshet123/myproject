import { LightningElement ,track,wire} from 'lwc';
import getContactDetails from '@salesforce/apex/HandleAccountLWC.FetchContact';


export default class ConditionalRenderingUsingApex extends LightningElement {
    showError=false;
    showDetails=false;
   
 @wire(getContactDetails)
   contacts;
    handleChange(event){
        if(event.target.checked){
               
                this.showDetails = true;
                this.showError = false;
        }
        else{
        this.showError=true;
        this.showDetails=false;
        }
    }
}