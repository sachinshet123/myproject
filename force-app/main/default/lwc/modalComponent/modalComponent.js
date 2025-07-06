import { LightningElement } from 'lwc';

export default class ModalComponent extends LightningElement {
    isModalOpen = false;

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    handleSave() {
        alert('Save button clicked!');
        this.closeModal();
    }
}