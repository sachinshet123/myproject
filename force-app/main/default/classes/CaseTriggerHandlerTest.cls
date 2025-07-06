@isTest
public class CaseTriggerHandlerTest {
	@isTest
    public static void testUpdateAccounts() {
        Account acc = new Account(Name='test acc');
        insert acc;
        Case cs = new Case(Origin='Phone', AccountId=acc.Id);
        Case cs1 = new Case(Origin='Phone');
        List<Case> csList = new List<Case>();
        csList.add(cs);
        csList.add(cs1);
        insert csList;
        Test.startTest();
        CaseTriggerHandler.updateAccountObject(csList);
        Test.stopTest();
        
        List<Account> getAccList = [SELECT Id, 	Latest_Case_Number_New__c FROM Account WHERE Id = :acc.Id]; 
        System.assertEquals(getAccList[0].Latest_Case_Number_New__c, cs.CaseNumber, 'case numbers are not equal');
        System.assertEquals(null, cs1.CaseNumber, 'case numbers are null');
    }
}