trigger TriggerOnCase on Case (after insert, after delete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            //CaseTriggerHandler.updateCaseCounts(Trigger.new, true); // Increment counts
        } else if (Trigger.isDelete) {
            //CaseTriggerHandler.updateCaseCounts(Trigger.old, false); // Decrement counts
        }
    }
}