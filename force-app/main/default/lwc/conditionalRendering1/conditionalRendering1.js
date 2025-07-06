import { LightningElement } from 'lwc';




export default class ConditionalRendering1 extends LightningElement {
    showError=false;
    showDetails=false;


    details=[
        {
            Id:'01',
            Name:'Sanjay Gupta',
            Email: 'contact@sgts.org.in',
            Phone:+919829011904,
            Address:'Jaipur India'
        }
    ];
    handleChange(event){
        if(event.target.checked){
        this.showError=false;
        this.showDetails=true;
        }
        else{
        this.showError=true;
        this.showDetails=false;
        }
    }


 
}