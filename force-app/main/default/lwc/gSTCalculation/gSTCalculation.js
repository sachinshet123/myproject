import { LightningElement } from 'lwc';

export default class GSTCalculation extends LightningElement {
    totalBillAmount = '';

    quantity1 = '';
    price1 = '';

    quantity2 = '';
    price2 = '';

    quantity3 = '';
    price3 = '';

    quantity4 = '';
    price4 = '';

    quantity5 = '';
    price5 = '';

    handleQuantity1(event) {
        if(isNaN(event.target.value)) {
            return;
        }
        this.quantity1 = parseInt(event.target.value);
    }
    handlePrice1(event) {
        if(isNaN(event.target.value)) {
            return;
        }
        this.price1 = parseFloat(event.target.value);
    }

    handleQuantity2(event) {
        if(isNaN(event.target.value)) {
            return;
        }
        this.quantity2 = parseInt(event.target.value);
    }
    handlePrice2(event) {
        if(isNaN(event.target.value)) {
            return;
        }
        this.price2 = parseFloat(event.target.value);
    }

    handleQuantity3(event) {
        if(isNaN(event.target.value)) {
            return;
        }
        this.quantity3 = parseInt(event.target.value);
    }
    handlePrice3(event) {
        if(isNaN(event.target.value)) {
            return;
        }
        this.price3 = parseFloat(event.target.value);
    }

    handleQuantity4(event) {
        if(isNaN(event.target.value)) {
            return;
        }
        this.quantity4 = parseInt(event.target.value);
    }
    handlePrice4(event) {
        if(isNaN(event.target.value)) {
            return;
        }
        this.price4 = parseFloat(event.target.value);
    }

    handleQuantity5(event) {
        if(isNaN(event.target.value)) {
            return;
        }
        this.quantity5 = parseInt(event.target.value);
    }
    handlePrice5(event) {
        if(isNaN(event.target.value)) {
            return;
        }
        this.price5 = parseFloat(event.target.value);
    }

    calculateTotalBillAmount() {
        this.totalBillAmount = parseFloat(this.quantity1 * this.price1) + parseFloat(((this.quantity1 * this.price1) * 18) / 100)
        + parseFloat(this.quantity2 * this.price2) + parseFloat(((this.quantity2 * this.price2) * 18) / 100) +
        parseFloat(this.quantity3 * this.price3) + parseFloat(((this.quantity3 * this.price3) * 18) / 100) +
        parseFloat(this.quantity4 * this.price4) + parseFloat(((this.quantity4 * this.price4) * 18) / 100) +
        parseFloat(this.quantity5 * this.price5) + parseFloat(((this.quantity5 * this.price5) * 18) / 100);
    }

}