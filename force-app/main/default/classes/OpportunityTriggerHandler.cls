public class OpportunityTriggerHandler {
    /*
        public static void updateDescription(List<Opportunity> oppList) {
            for (Opportunity opp : oppList) {
                if (opp.Amount != null && opp.Amount > 100000) {
                    opp.Description = 'Hot Opportunity';
                }
            }
        }
        
        public static void updateLatestAmountOnAccount(List<Opportunity> oppList) {
            Id accId;
            Decimal Amount;
            for (Opportunity opp : oppList) {
                if (opp.AccountId != null) {
                    accId = opp.AccountId;
                    Amount = opp.Amount;
                }
            }
            List<Account> accList = [SELECT Id, Recent_Opportunity_Amount__c FROM Account WHERE Id = :accId];
            for (Account acc : accList) {
                acc.Recent_Opportunity_Amount__c = Amount;
            }
            update accList;
        }
        
        public static void updateDescriptionForupdateInStage(List<Opportunity> oppList) {
            if (oppList != null) {
                for (Opportunity opp : oppList) {
                    Opportunity oldOpportunityRecord = (Opportunity) Trigger.Old.get(0);
                    if (opp.StageName != oldOpportunityRecord.StageName) {
                        if (opp.StageName == 'Closed Won') {
                            opp.Description = 'Opportunity is Closed Won';
                        } else if (opp.StageName == 'Closed Lost') {
                            opp.Description = 'Opportunity is Closed Lost';
                        } else if (opp.StageName != 'Closed Won' || opp.StageName != 'Closed Lost') {
                            opp.Description = 'Opportunity is Open';
                        }
                    }
                }
            }
        }
        
        public static void createTaskForOpportunity(List<Opportunity> newOppList, List<Opportunity> oldOppList) {
            List<Task> taskList = new List<Task>();
            for (Integer i = 0; i < newOppList.size(); i++) {
                Opportunity newOpp = newOppList[i];
                Opportunity oldOpp = oldOppList[i];
                
                if (newOpp.StageName != oldOpp.StageName) {
                    Task tsk = new Task();
                    tsk.Subject = 'Other';
                    tsk.WhatId = newOpp.Id;
                    taskList.add(tsk);
                }
            }
            insert taskList;
        }
        
        public static void validateAmount(List<Opportunity> newOppList) {
            for (Opportunity opp : newOppList) {
                if (opp.Amount == null) {
                    opp.addError(Label.Amount_Empty);
                }
            }
        }
        
        public static void populateAmountOnAccount(List<Opportunity> oppList, Map<Id, Opportunity> oldMap) {
            Set<Id> accIds = new Set<Id>();
            
            // Handling insert, update, or undelete operations
            for (Opportunity opp : oppList) {
                if (opp.AccountId != null && opp.Amount != null && oldMap == null) {
                    accIds.add(opp.AccountId);
                } else {
                    if (oldMap != null) {
                        // Update scenario: check if the Amount has changed
                        if (opp.AccountId != null && opp.Amount != oldMap.get(opp.Id).Amount) {
                            accIds.add(opp.AccountId);
                        }
                    }
                }
            }
            // If there are any Account IDs to update
            if (!accIds.isEmpty()) {
                List<Account> accList = [SELECT Id, AnnualRevenue, (SELECT Id, Amount FROM Opportunities) FROM Account WHERE Id IN :accIds];
                
                for (Account acc : accList) {
                    Decimal total = 0;
                    // Sum up the Amount for all Opportunities associated with the Account, excluding deleted ones
                    for (Opportunity opp : acc.Opportunities) {
                        total += opp.Amount;
                    }
                    acc.AnnualRevenue = total; // Recalculate AnnualRevenue
                }
                update accList;
            }
        }
        
        public static void deductAmountFromAccount(List<Opportunity> deletedOpportunities) {
            // Set to hold Account IDs
            Set<Id> accountIds = new Set<Id>();
            
            // Collect Account IDs related to deleted Opportunities
            for (Opportunity opp : deletedOpportunities) {
                if (opp.AccountId != null && opp.Amount != null) {
                    accountIds.add(opp.AccountId);
                }
            }
            
            // If there are Accounts to update
            if (!accountIds.isEmpty()) {
                // Query Accounts and related Opportunities
                List<Account> accountsToUpdate = [SELECT Id, AnnualRevenue, 
                                                  (SELECT Id, Amount FROM Opportunities WHERE IsDeleted = TRUE) 
                                                  FROM Account WHERE Id IN :accountIds];
                
                // Loop through the Accounts and adjust AnnualRevenue
                for (Account acc : accountsToUpdate) {
                    // Deduct the Amount of deleted Opportunities
                    for (Opportunity deletedOpp : deletedOpportunities) {
                        if (deletedOpp.AccountId == acc.Id) {
                            acc.AnnualRevenue = acc.AnnualRevenue - deletedOpp.Amount; // Subtract the deleted Opportunity's Amount
                        }
                    }
                }
                // Update the Account records
                update accountsToUpdate;
            }
        }
        
        public static void updateAnnualRevenueFieldOnAccount(List<Opportunity> newOppList, Map<Id, Opportunity> oldOppMap) {
            Set<Id> accIds = new Set<Id>();
            for (Opportunity opp : newOppList) {
                System.debug('newOppList' + newOppList);
                if (opp.AccountId != null && opp.Amount != null && oldOppMap == null) {
                    accIds.add(opp.AccountId);
                } else {
                    if (oldOppMap != null) {
                        if (opp.AccountId != null && opp.Amount != null && opp.Amount != oldOppMap.get(opp.Id).Amount) {
                            accIds.add(opp.AccountId);
                        }
                    }
                }
            }
            List<Opportunity> oppList = [SELECT Id, Amount, AccountId FROM Opportunity WHERE AccountId IN :accIds];
            Map<Id, Account> updateAccMap = new Map<Id, Account>();
            for (Opportunity opp : oppList) {
                Account acc = new Account(Id = opp.AccountId);
                if (updateAccMap.containsKey(opp.AccountId)) {
                    acc.AnnualRevenue = updateAccMap.get(opp.AccountId).AnnualRevenue + opp.Amount;
                } else {
                    acc.AnnualRevenue = opp.Amount;
                }
                updateAccMap.put(opp.AccountId, acc);
            }
            update updateAccMap.values();
        }
        
        public static void updateAnnualRevenueFieldOnDeletedOpportunities(List<Opportunity> oldOpportunities) {
            Set<Id> accIds = new Set<Id>();
            for(Opportunity opp : oldOpportunities) {
                if(opp.AccountId != null && opp.Amount != null) {
                    accIds.add(opp.AccountId);
                }
            }
            if(!accIds.isEmpty()) {
                List<Account> accList = [SELECT Id, AnnualRevenue FROM Account WHERE Id IN : accIds];
                for(Account acc : accList) {
                    for(Opportunity opp : oldOpportunities) {
                        if(acc.Id == opp.AccountId) {
                            acc.AnnualRevenue = acc.AnnualRevenue - opp.Amount;
                            System.debug('Annual Revenue is ' + acc.AnnualRevenue);
                            if(acc.AnnualRevenue == 0) {
                                acc.AnnualRevenue = null;
                            }
                        }
                        update accList;
                    }
                }
            }
            
        }
        public static void updateAnnualRevenueFieldOnDeletedOpportunitiesUsingMap(List<Opportunity> oldOpportunities) {
            Set<Id> accIds = new Set<Id>();
            for(Opportunity opp : oldOpportunities) {
                if(opp.AccountId != null && opp.Amount != null) {
                    accIds.add(opp.AccountId);
                }
            }
            if(!accIds.isEmpty()) {
                Map<Id, Account> accListMap = new Map<Id, Account>([SELECT Id, AnnualRevenue FROM Account WHERE Id IN : accIds]);
                for(Account acc : accListMap.values()) {
                    for(Opportunity opp : oldOpportunities) {
                        if(accListMap.containsKey(opp.AccountId)) {
                            acc.AnnualRevenue = acc.AnnualRevenue - opp.Amount;
                            if(acc.AnnualRevenue == 0) {
                                acc.AnnualRevenue = null;
                            }
                        }
                    }
                    update accListMap.values();
                }
            }
        }
        private static Boolean recursionCheck = false;
        public static void updateOpportunityDescriptionClosedWon(List<Opportunity> newOppList, Map<Id,Opportunity> oldOppList) {
            if(recursionCheck) {
                return;
            }
            recursionCheck = true;
            for(Opportunity opp : newOppList) {
                if(opp.StageName != oldOppList.get(opp.Id).StageName && opp.StageName == 'Closed Won') {
                    opp.Description = 'Opportunity is closed won.....';
                }
                //update newOppList;
            }
        }
        public static void updateOpportunityDescriptionClosedLost(List<Opportunity> newOppList, Map<Id,Opportunity> oldOppList) {
            if(recursionCheck) {
                return;
            }
            recursionCheck = true;
            for(Opportunity opp : newOppList) {
                if(opp.StageName != oldOppList.get(opp.Id).StageName && opp.StageName == 'Closed Lost') {
                    opp.Description = 'Opportunity is closed lost.....';
                }
                //update newOppList;  // no explicit statement required here
            }
        }
        public static void updateAccountStatusToActiveNo(List<Opportunity> newOppList, Map<Id, Opportunity> oldOppMap) {
            Set<Id> accIds = new Set<Id>();
            
            // Identify accounts linked to opportunities that have changed to "Closed Lost"
            for (Opportunity opp : newOppList) {
                if (opp.StageName != oldOppMap.get(opp.Id).StageName && opp.StageName == 'Closed Lost' && opp.AccountId != null) {
                    accIds.add(opp.AccountId);
                }
            }
            
            // Query accounts related to the identified Account IDs
            List<Account> accList = [SELECT Id, Active__c FROM Account WHERE Id IN :accIds];
            
            // Update the Active__c field to "No"
            for (Account acc : accList) {
                acc.Active__c = 'No';
            }
            
            // Perform the update operation
            if (!accList.isEmpty()) {
                update accList;
            }
        }
    public static void updateDiscounts(List<Opportunity> oppNewList) {
        List<Opportunity> updateOppList = new List<Opportunity>();
        for(Opportunity opp : oppNewList) {
            if(opp.Amount != null) {
                DiscountCalculator.applyDiscount(opp);
                updateOppList.add(opp);
            }
    	}
    }
    public static void transferTheFilesFromOpportunityToParentAccount(List<Opportunity> newOppList, Map<Id, Opportunity> oldOppMap) {
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
        for(Opportunity opp : newOppList) {
            if(opp.AccountId != null && opp.StageName == 'Closed Won' && opp.StageName != oldOppMap.get(opp.Id).StageName) {
                oppMap.put(opp.Id, opp);
            }
        }
        if(oppMap.isEmpty()) {
            System.debug('No relevant opportunities found');
            return;
        }
            List<ContentDocumentLink> docuLinkOppList = [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN : oppMap.keySet()];
            List<ContentDocumentLink> docuLinkAccList = new List<ContentDocumentLink>();
            for(ContentDocumentLink docuLink : docuLinkOppList) {
                ContentDocumentLink docuLinkObj = new ContentDocumentLink();
                docuLinkObj.ContentDocumentId = docuLink.ContentDocumentId;
                docuLinkObj.LinkedEntityId = oppMap.get(docuLink.LinkedEntityId).AccountId;
                docuLinkObj.ShareType = 'V';
                docuLinkObj.Visibility = 'AllUsers';
            }
        if(!docuLinkAccList.isEmpty()) {
            insert docuLinkAccList;
            System.debug('Files successfully linked to account');
        } else {
            System.debug('No files found on opportunities');
        }
    }
*/
    
    
    public static void updateDescription(List<Opportunity> oppList) {
        for(Opportunity opp : oppList) {
            if(opp.Amount != null && opp.Amount > 100000) {
                opp.Description = 'Hot opportunity';
            }
        }
    }
    
    public static void updateRecentOpportunityAmount(List<Opportunity> oppList) {
        System.debug('trigger2');
        List<Account> updateAcc = new List<Account>();
        for(Opportunity opp : oppList) {
            if(opp.AccountId != null && opp.Amount != null ) {
                Account acc = new Account();
                acc.Id = opp.AccountId;
                acc.Recent_Opportunity_Amount_New__c = opp.Amount;
                updateAcc.add(acc);
            } 
        }
        update updateAcc;
        System.debug('trigger3');
    }
    
    public static void updateDescriptionForStage(Map<Id, Opportunity> newOppList, Map<Id, Opportunity> oldOppList) {
        if(newOppList != null && oldOppList != null) {
            for(Opportunity opp : newOppList.values()) {
                if(opp.StageName != oldOppList.get(opp.Id).StageName && opp.StageName == 'Closed Lost' || opp.StageName == 'Closed Won') {
                    opp.Description = 'opp is closed lost or closed won';
                }
                else {
                    opp.Description = 'opp is open';
                }
            }
        }
    }
    
    public static void createTheTask(List<Opportunity> newOppList, Map<Id, Opportunity> oldOppMap) {
    List<Task> tlist = new List<Task>();

    if (newOppList != null && oldOppMap != null) {
        for (Opportunity opp : newOppList) {
            Opportunity oldOpp = oldOppMap.get(opp.Id);
            if (oldOpp != null && opp.StageName != oldOpp.StageName) {
                Task t = new Task();
                t.WhatId = opp.Id;
                t.Subject = 'Email'; 
                t.Priority = 'Normal';
                t.Status = 'Not Started';
                t.OwnerId = UserInfo.getUserId();
                tlist.add(t);
            }
        }
    }

    if (!tlist.isEmpty()) {
        insert tlist;
    }
}

    
}