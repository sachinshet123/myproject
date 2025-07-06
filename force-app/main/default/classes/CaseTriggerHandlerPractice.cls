public class CaseTriggerHandlerPractice {
    public static void countRecordtypeCases(List<Case> caseList, Boolean isIncrementOrDecrement) {
        Map<Id, Integer> partnerCaseCountMap = new Map<Id, Integer>();
        Map<Id, Integer> customerCaseCountMap = new Map<Id, Integer>();
        
        //fetch the record type ids for partner case and customer case
     Map<String, Schema.RecordTypeInfo> recordTypeMap = Schema.SObjectType.Case.getRecordTypeInfosByName();
        Id partnerRecordTypeId = recordTypeMap.get('Partner Case').getRecordTypeId();
        Id customerRecordTypeId = recordTypeMap.get('Customer Case').getRecordTypeId();
        
        for(Case c : caseList) {
            if(c.AccountId == partnerRecordTypeId) {
                if(!partnerCaseCountMap.containsKey(c.AccountId)) {
                    partnerCaseCountMap.put(c.AccountId, 0);
                }
                partnerCaseCountMap.put(c.AccountId, partnerCaseCountMap.get(c.AccountId) + (isIncrementOrDecrement ? 1 : -1));
            }
            if(c.AccountId == customerRecordTypeId) {
                if(!customerCaseCountMap.containsKey(c.AccountId)) {
                    customerCaseCountMap.put(c.AccountId, 0);
                }
                customerCaseCountMap.put(c.AccountId, customerCaseCountMap.get(c.AccountId) + 
                                      (isIncrementOrDecrement ? 1 : -1));
            }
            
        }
        List<Id> combinedKeys = new List<Id>();
        combinedKeys.addAll(partnerCaseCountMap.keySet());
        combinedKeys.addAll(customerCaseCountMap.keySet());
        
        List<Account> updateAccList = new List<Account>();
        Map<Id, Account> accMap = new Map<Id, Account>(
        				[SELECT Id, Total_Number_Of_Partner_Case__c, Total_Number_Of_Customer_Case__c FROM Account
                        WHERE Id IN : combinedKeys]);
        
        for(Id accId : combinedKeys) {
            Account acc = accMap.get(accId);
            acc.Total_Number_Of_Partner_Case__c = 
                (acc.Total_Number_Of_Partner_Case__c != null ? acc.Total_Number_Of_Partner_Case__c : 0) + (!partnerCaseCountMap.containsKey(accId) ? 
                                                                                                          partnerCaseCountMap.get(accId) : 0);
            acc.Total_Number_Of_Customer_Case__c = 
                (acc.Total_Number_Of_Customer_Case__c != null ? acc.Total_Number_Of_Customer_Case__c : 0) + (!customerCaseCountMap.containsKey(accId) ? 
                                                                                                          customerCaseCountMap.get(accId) : 0);
            
            updateAccList.add(acc);
        }
        
        if(!updateAccList.isEmpty()) {
            update updateAccList;
        }
        
    }
}