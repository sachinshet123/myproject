trigger OpportunityTrigger on Opportunity (before insert, after insert, before update, after update, after delete, after undelete) {
  /*  if(Trigger.isInsert) {
        if(Trigger.isBefore) {
            //OpportunityTriggerHandler.updateDescription(Trigger.New);
            //OpportunityTriggerHandler.validateAmount(Trigger.New);
        }
        if(Trigger.isAfter) {
            //OpportunityTriggerHandler.updateLatestAmountOnAccount(Trigger.New);
        }   
    }
    if(Trigger.isUpdate) {
        if(Trigger.isBefore) {
            //OpportunityTriggerHandler.updateDescriptionForupdateInStage(Trigger.New);
            //OpportunityTriggerHandler.updateClosedLostReason(Trigger.New, Trigger.Old);
            //OpportunityTriggerHandler.updateOpportunityDescriptionClosedWon(Trigger.new, Trigger.oldMap);
            //OpportunityTriggerHandler.updateOpportunityDescriptionClosedLost(Trigger.new, Trigger.oldMap);
        }
        if(Trigger.isAfter) {
            //OpportunityTriggerHandler.createTaskForOpportunity(Trigger.new, Trigger.old); 
            //OpportunityTriggerHandler.updateAccountStatusToActiveNo(Trigger.new, Trigger.oldMap);
            OpportunityTriggerHandler.transferTheFilesFromOpportunityToParentAccount(Trigger.new, Trigger.oldMap);
        }
    }
    if(Trigger.isDelete) {
        if(Trigger.isBefore) {
            //OpportunityTriggerHandler.dontDeleteIfProfileIsNotSystemAdmin(Trigger.Old);
        }
    }
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        if(Trigger.isAfter) {
            //OpportunityTriggerHandler.populateAmountOnAccount(Trigger.new, Trigger.oldMap);
            //OpportunityTriggerHandler.populateAmountOnAccountUsingMap(Trigger.new, Trigger.oldMap);
            //OpportunityTriggerHandler.updateAnnualRevenueFieldOnAccount(Trigger.new, Trigger.oldMap);
        }
    }
    
    if (Trigger.isDelete) {
        if(Trigger.isAfter) {	
            //OpportunityTriggerHandler.deductAmountFromAccount(Trigger.old);
            //OpportunityTriggerHandler.deductAmountFromAccountUsingMap(Trigger.old);
           	//OpportunityTriggerHandler.updateAnnualRevenueFieldOnDeletedOpportunities(Trigger.old);
           	//OpportunityTriggerHandler.updateAnnualRevenueFieldOnDeletedOpportunitiesUsingMap(Trigger.old);
        }
    }
    if(Trigger.isInsert || Trigger.isUpdate) {
        if(Trigger.isBefore) {
            OpportunityTriggerHandler.updateDiscounts(Trigger.new);
        }
    }*/
    
    
    
    
    if(Trigger.isBefore && Trigger.isInsert) {
        try {
            OpportunityTriggerHandler.updateDescription(Trigger.new);
        } catch(Exception e) {
            System.debug('exception is ' +e.getMessage());
        }
    }
    if(Trigger.isAfter && Trigger.isInsert || Trigger.isAfter && Trigger.isUpdate) {
    try {
        	System.debug('trigger1');
          //OpportunityTriggerHandler.updateRecentOpportunityAmount(Trigger.new);
        System.debug('trigger4');
        } catch(Exception e) {
          System.debug('exception is ' +e.getMessage());
        }
    }
    if(Trigger.isUpdate && Trigger.isBefore) {
        OpportunityTriggerHandler.updateDescriptionForStage(Trigger.newMap, Trigger.oldMap);
    }
    if(Trigger.isUpdate && Trigger.isAfter) {
        OpportunityTriggerHandler.createTheTask(Trigger.new, Trigger.oldMap);
    }
}