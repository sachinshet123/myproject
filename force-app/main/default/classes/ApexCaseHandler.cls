public class ApexCaseHandler {
    public static void updateAccounts(List<Case> caseList) {
        Id accId;
        String CaseNumber;
        for(Case cs : caseList) {
            if(cs.AccountId != NULL) {
                accId = cs.AccountId;
                CaseNumber = cs.CaseNumber;
            }
        }
        List<Account> accList = [SELECT Id, Latest_Case_Number__c FROM Account WHERE Id = :accId];
        for(Account acc : accList) {
           acc.Latest_Case_Number__c = CaseNumber;
        }
        update accList;
    }
}