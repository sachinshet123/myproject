import { LightningElement } from 'lwc';

export default class Skills extends LightningElement {
    skills = [{ id: 0, name: '' }];

    handleSkillChange(event) {
        const index = Number(event.target.dataset.index);
        const updatedValue = event.target.value;

        this.skills[index] = { ...this.skills[index], name: event.target.value };
        this.skills = [...this.skills]; // Trigger reactivity
        this.dispatchUpdate();
    }

    addSkill() {
        this.skills = [...this.skills, { id: this.skills.length, name: '' }];
    }

    dispatchUpdate() {
        this.dispatchEvent(new CustomEvent('updateskill', { detail: this.skills }));
    }
}