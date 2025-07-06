trigger CaseTrigger on Case (after insert, before insert) {
   /* if(Trigger.isInsert) {
        if(Trigger.isAfter) {
            //ApexCaseHandler.updateAccounts(Trigger.New);
        }
        if(Trigger.isBefore) {
            for(Case caseRecord : Trigger.new) {
                //ServiceLevelCalculator.setTargetResponseTime(caseRecord);
            }
        }
    }*/
    if(Trigger.isInsert && Trigger.isAfter) {
        try {
            CaseTriggerHandler.updateAccountObject(Trigger.new);
        } catch(Exception e) {
            System.debug('error is ' + e.getMessage());
        }
    }
}