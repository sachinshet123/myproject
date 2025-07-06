trigger AccountTriggerFile on Account (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
  /*  if(Trigger.isInsert && Trigger.isBefore) {
        //AccountTriggerHandler.updateDescription(Trigger.New);
        //AccountTriggerHandler.updateRating(Trigger.New);
        //AccountTriggerHandler.updateBillingToShippingAddress(Trigger.New);
        //AccountTriggerHandler.accountInsertedOrUpdatedThenUpdateAddress(Trigger.New);  
        //AccountTriggerHandler.blockDuplicateRecords(Trigger.new);
    }
    if(Trigger.isInsert && Trigger.isAfter) {
        //AccountTriggerHandler.createRelatedContact(Trigger.New);
        //AccountTriggerHandler.createRelatedOpportunity6(Trigger.New);
        //AccountTriggerHandler.updateContactAndOpportunities(Trigger.New); 
        //AccountTriggerHandler.insertOpportunities(Trigger.new);
        //Feature_Toggle__mdt featureToggle = [SELECT IsActive_c__c FROM Feature_Toggle__mdt WHERE DeveloperName = 'Example_Feature' LIMIT 1];
        //if(featureToggle.IsActive_c__c) {
        //   ToggleFeature.createContacts(Trigger.new);
        //}
        List<Feature_Toggle_Custom__c> featureToggleCustom = Feature_Toggle_Custom__c.getAll().values();
        for(Feature_Toggle_Custom__c featureToggle : featureToggleCustom) {
            if(featureToggle.Is_Active__c) {
            //ToggleFeatureCustom.createContacts(Trigger.new);
        }
        }
    }
        
        if(Trigger.isExecuting) {
            System.debug('Trigger is Executing' + Trigger.isExecuting);
        }
    if(Trigger.isUpdate && Trigger.isBefore) {
        //AccountTriggerHandler.updateAccountDescriptionPhone(Trigger.New);
        //AccountTriggerHandler.updateAccountDescriptionPhoneNew(Trigger.New);
        //AccountTriggerHandler.accountInsertedOrUpdatedThenUpdateAddress(Trigger.New);
        //AccountTriggerHandler.updateRating(Trigger.New);
        //AccountTriggerHandler.blockUpdatecreatedSevenDaysBefore(Trigger.Old, Trigger.New);
    }
    if(Trigger.isUpdate && Trigger.isAfter) {
        //AccountTriggerHandler.updateAccountPhoneThenInAllContacts(Trigger.OldMap, Trigger.NewMap);
        //AccountTriggerHandler.updateAccountPhoneThenInAllContactsUsingParentChild(Trigger.New, Trigger.Old);
        //AccountTriggerHandler.updateAccountBillingAddressToMailingAddressInRelatedContacts(Trigger.OldMap, Trigger.NewMap); 
        //AccountTriggerHandler.updateAccountBillingAddressToMailingAddressInRelatedContactsUsingParentChild(Trigger.New, Trigger.Old); 
        //AccountTriggerHandler.updateStageofAllOpportunitiesRelatedtoAccount(Trigger.Old, Trigger.New);
        //AccountTriggerHandler.undeleteDeletedRecords(Trigger.Old, Trigger.New);
        //AccountTriggerHandler.updateContacts(Trigger.newMap);
        //AccountTriggerHandler.updateOpportunityStatusToClosedLost(Trigger.new, Trigger.oldMap);
        //AccountTriggerHandler.updateOwnerFieldOnContacts(Trigger.new, Trigger.oldMap);
    }
    
    if(Trigger.isDelete && Trigger.isBefore) {
        //AccountTriggerHandler.beforeDeleteAccounts(Trigger.Old);
        //AccountTriggerHandler.onlyForSystemAdminProfile(Trigger.Old);
        //AccountTriggerHandler.notAbletodeleteifhasrelatedaccoutnts(Trigger.Old);
        //AccountTriggerHandler.preventDeletionOfAccountifOpportunityStatusIsClosed(Trigger.Old);
        //AccountTriggerHandler.preventDeletionOfCases(Trigger.Old);
        //AccountTriggerHandler.preventDeletionOfChildObjects(Trigger.oldMap);
    }
    
    
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            //AccountTriggerHandler.blockDuplicateRecords(Trigger.new);
        }
    }*/
    
    
    
    if(Trigger.isBefore && Trigger.isInsert) {
        //AccountTriggerHandler.updateAccount(Trigger.new);
    }
        
        if(Trigger.isInsert && Trigger.isAfter) {
            //AccountTriggerHandler.updateBillingAddressToShippingAddress(Trigger.new);
    }
    
    if(Trigger.isInsert && Trigger.isAfter) {
            //AccountTriggerHandler.createRelatedContacts(Trigger.new);
    }
    
    if (Trigger.isInsert && Trigger.isAfter) {
            //AccountTriggerHandler.createRelatedOpportunities(Trigger.new);
    }
    
    if (Trigger.isInsert && Trigger.isAfter) {
            //AccountTriggerHandler.createRelatedContactsAndOpportunities(Trigger.new);
    }
    
    if (Trigger.isUpdate && Trigger.isBefore) {
            //AccountTriggerHandler.updateDescription(Trigger.new, Trigger.oldMap);
    }
    
    if (Trigger.isInsert && Trigger.isBefore || Trigger.isUpdate && Trigger.isBefore) {
        //AccountTriggerHandler.copyBillingToShipping(Trigger.new, Trigger.oldMap);
    }
    
    if(Trigger.isInsert && Trigger.isBefore || Trigger.isUpdate && Trigger.isBefore) {
        AccountTriggerHandler.updateRating(Trigger.new, Trigger.oldMap);
    }
    if(Trigger.isUpdate && Trigger.isAfter) {
        //AccountTriggerHandler.updateRelatedContactPhoneFieldUsingMap(Trigger.new, Trigger.oldMap);
        AccountTriggerHandler.updateRelatedContactPhoneFieldUsingChildToParent(Trigger.new, Trigger.oldMap);
    }
    if(Trigger.isUpdate && Trigger.isAfter) {
        //AccountTriggerHandler.updateRelatedBillingToMailingAddressUsingChildToParent(Trigger.new, Trigger.oldMap);
    }
    if(Trigger.isUpdate && Trigger.isAfter) {
        AccountTriggerHandler.updateRelatedBillingAddressToMailingAddressdUsingMap(Trigger.new, Trigger.oldMap);
    }
    if(Trigger.isUpdate && Trigger.isAfter) {
        AccountTriggerHandler.updateOpportunityStatus(Trigger.new, Trigger.oldMap);
    }
    
    if(Trigger.isDelete && Trigger.isBefore) {
        AccountTriggerHandler.cannotdeleteifaccountactive(Trigger.old);
    }
    
    if(Trigger.isUpdate && Trigger.isBefore) {
        AccountTriggerHandler.preventRecordUpdateCreatedSevenDaysBack(Trigger.new);
    }
}