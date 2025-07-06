public class CaseTriggerHandler {
   /* public static void updateCaseCounts(List<Case> caseList, Boolean isIncrement) {
        Map<Id, Integer> partnerCaseCountMap = new Map<Id, Integer>();
        Map<Id, Integer> customerCaseCountMap = new Map<Id, Integer>();

        // Fetch the record type IDs for Partner Case and Customer Case
        Map<String, Schema.RecordTypeInfo> recordTypeMap = Schema.SObjectType.Case.getRecordTypeInfosByName();
        Id partnerRecordTypeId = recordTypeMap.get('Partner Case').getRecordTypeId();
        Id customerRecordTypeId = recordTypeMap.get('Customer Case').getRecordTypeId();

        // Iterate through cases to calculate counts
        for (Case c : caseList) {
            if (c.AccountId != null) {
                if (c.RecordTypeId == partnerRecordTypeId) {
                    if (!partnerCaseCountMap.containsKey(c.AccountId)) {
                        partnerCaseCountMap.put(c.AccountId, 0);
                    }
                    partnerCaseCountMap.put(c.AccountId, 
                        partnerCaseCountMap.get(c.AccountId) + (isIncrement ? 1 : -1));
                } else if (c.RecordTypeId == customerRecordTypeId) {
                    if (!customerCaseCountMap.containsKey(c.AccountId)) {
                        customerCaseCountMap.put(c.AccountId, 0);
                    }
                    customerCaseCountMap.put(c.AccountId, 
                        customerCaseCountMap.get(c.AccountId) + (isIncrement ? 1 : -1));
                }
            }
        }

        // Combine keys from both maps
        Set<Id> combinedKeys = new Set<Id>();
        combinedKeys.addAll(partnerCaseCountMap.keySet());
        combinedKeys.addAll(customerCaseCountMap.keySet());

        // Query accounts that need updates
        Map<Id, Account> accList = new Map<Id, Account>([
            SELECT Id, Total_Number_Of_Partner_Case__c, Total_Number_Of_Customer_Case__c 
            FROM Account 
            WHERE Id IN :combinedKeys
        ]);

        // Update account counts
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : combinedKeys) {
            Account acc = accList.get(accId);

            // Update Partner Case count
            acc.Total_Number_Of_Partner_Case__c = 
                (acc.Total_Number_Of_Partner_Case__c != null ? acc.Total_Number_Of_Partner_Case__c : 0) 
                + (partnerCaseCountMap.containsKey(accId) ? partnerCaseCountMap.get(accId) : 0);

            // Update Customer Case count
            acc.Total_Number_Of_Customer_Case__c = 
                (acc.Total_Number_Of_Customer_Case__c != null ? acc.Total_Number_Of_Customer_Case__c : 0) 
                + (customerCaseCountMap.containsKey(accId) ? customerCaseCountMap.get(accId) : 0);
            accountsToUpdate.add(acc);
        }
        // Perform update
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }*/
    public static void updateAccountObject(List<Case> caseList) {
        
        List<Account> updateAcc = new List<Account>();
        for(Case cs : caseList) {
            if(cs.AccountId != null) {
             Account acc = new Account();
             acc.Id = cs.AccountId;
             acc.Latest_Case_Number_New__c = cs.CaseNumber;
             updateAcc.add(acc);   
            }
        }
        update updateAcc;
    }
}