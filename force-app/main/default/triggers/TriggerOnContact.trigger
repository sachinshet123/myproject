trigger TriggerOnContact on Contact (after insert, after update, before insert, before update, after delete, after undelete) {
    if(Trigger.isInsert && Trigger.isAfter) {
        //ContactTriggerHandler.sendEmailtoContact(Trigger.new);
        Validatephone.afterInsertphone(Trigger.new);
    }
    if(Trigger.isUpdate && Trigger.isAfter) {
        //ContactTriggerHandler.updateAccount(Trigger.newMap);
    }
    if(Trigger.isInsert || Trigger.isUpdate) {
        if(Trigger.isBefore) {
            //ContactTriggerHandler.checkDuplicationOfRecords(Trigger.new, Trigger.oldMap);
        }
    }
    if(Trigger.isInsert || Trigger.isDelete || Trigger.isUndelete) {
        if(Trigger.isAfter) {
            ContactTriggerHandler.updateTotalContacts(Trigger.new, Trigger.old);
        }
    }
    
    
}