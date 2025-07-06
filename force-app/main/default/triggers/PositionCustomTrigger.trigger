trigger PositionCustomTrigger on Position__c (before insert) {
    if(Trigger.isBefore && Trigger.isInsert) {
        try {
            PositionTrigggerHandler.populateWithTheBasicDetails(Trigger.new);
        } catch(Exception e) {
            System.debug('error is ' + e.getMessage());
        }
    }
}