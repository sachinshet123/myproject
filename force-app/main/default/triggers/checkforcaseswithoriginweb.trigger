trigger checkforcaseswithoriginweb on Case (after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        TriggerHandlerForDeleteCase.callMethod(Trigger.new);
    }
}