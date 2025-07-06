trigger TriggerOnCasePractice on Case (after insert, after delete) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            CaseTriggerHandlerPractice.countRecordtypeCases(Trigger.new, true);
        }
        else {
            CaseTriggerHandlerPractice.countRecordtypeCases(Trigger.old, false);
        }
    }
}