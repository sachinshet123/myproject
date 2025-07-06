@isTest
public class AccountWithCasesTest {
	@isTest
    public static void testCountCases() {
        Account acc = new Account(Name = 'test account case');
        insert acc;
        Case cs1 = new Case(Origin = 'Phone', AccountId = acc.Id);
        Case cs2 = new Case(Origin = 'Web', AccountId = acc.Id);
        Case cs3 = new Case(Origin = 'Email', AccountId = acc.Id);
        insert cs1;
        insert cs2;
        insert cs3;
        
        //step 3 start the test process
        Test.startTest();
        AccountsWithCases.countContacts(new List<Id>{acc.Id});
        Test.stopTest();
        
        //step 4 check for the assert function
        Account updateAcc = [SELECT Id, Created_Email__c, Created_Phone__c, Created_Web__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(1, updateAcc.Created_Email__c, 'total count should be 1');
        System.assertEquals(1, updateAcc.Created_Phone__c, 'total count should be 1');
        System.assertEquals(1, updateAcc.Created_Web__c, 'total count should be 1');
    }
}