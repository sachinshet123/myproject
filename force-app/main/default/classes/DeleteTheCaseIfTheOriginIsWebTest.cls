@isTest
public class DeleteTheCaseIfTheOriginIsWebTest {
	@isTest
    public static void deleteTheCase() {
        // step 1 create account and case
        Account acc = new Account(Name='test case delete');
        insert acc;
        Case cs1 = new Case(Origin = 'Web', AccountId = acc.Id);
        Case cs2 = new Case(Origin = 'Phone', AccountId = acc.Id);
        Case cs3 = new Case(Origin = 'Email', AccountId = acc.Id);
        Case cs4 = new Case(Origin = 'Web', AccountId = acc.Id);
        insert cs1;
        insert cs2;
        insert cs3;
        insert cs4;
        
        delete cs1;
        
        //step2 run start test
        Test.startTest();
        DeleteTheCaseIfTheOriginIsWeb.deleteTheCaseOriginIsWeb(new List<Id>{acc.Id});
        Test.stopTest();
        
        //check for assertEquals
        Account updatedAcc = [SELECT Id, Created_Web__c, (SELECT Id, Origin FROM Cases) FROM Account WHERE Id = :acc.Id];
        
        System.assertEquals(1, updatedAcc.Created_Web__c, 'delete failed');
        
    }
}