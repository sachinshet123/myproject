trigger UserTrigger on User(after insert) {
    if(Trigger.isInsert && Trigger.isAfter) {
        UserTriggerHandler.addToPublicGroup(Trigger.new);
    }
}