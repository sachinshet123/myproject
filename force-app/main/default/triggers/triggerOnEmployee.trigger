trigger triggerOnEmployee on Employee__c (after delete, after undelete, after insert) {
    if(Trigger.isDelete) {
        if(Trigger.isAfter) {
            EmployeeTriggerHandler.leftEmployeeCount(Trigger.Old);
        }
    }
    if(Trigger.isInsert) {
        if(Trigger.isAfter) {
            EmployeeTriggerHandler.shareEmployeeRecords(Trigger.new);
        }
    }
    //List<Schema.PicklistEntry> stageValues = Opportunity.StageName.getDescribe().getPicklistValues();
//        List<String> pickListvalues = new List<String>();
//        for(Schema.PicklistEntry stgval : stageValues) {
//            pickListvalues.add(stgval.getValue());
//        }
//System.debug(pickListvalues);
    if(Trigger.isUndelete && Trigger.isAfter) {
        EmployeeTriggerHandler.reduceTheLeftEmployeeCount(Trigger.new);
    }
    if(Trigger.isInsert && Trigger.isAfter) {
        EmployeeTriggerHandler.reduceTheLeftEmployeeCount(Trigger.new);
    }
}