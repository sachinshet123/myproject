import { LightningElement } from 'lwc';

export default class FruitList extends LightningElement {
    fruits = [
        { id: 1, name: 'Apple' },
        { id: 2, name: 'Banana' },
        { id: 3, name: 'Cherry' }
    ];

    handleInputChange(event) {
        let fruitId = event.target.dataset.id;
        let fruit = this.fruits.find(fruit => fruit.id == fruitId);
        fruit.name = event.target.value;
        this.fruits = [...this.fruits]; // Ensures reactivity
    }
}