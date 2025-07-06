@isTest
public class AccountWithContactsTest {
	@isTest
    public static void testCountContacts() {
        //step 1 create account
        Account acc = new Account(Name='Test Account');
        insert acc;
        //step 2 create contacts
        for(Integer i = 0; i < 3; i++) {
            Contact con = new Contact(LastName='test account contact' + i);
            con.AccountId = acc.Id;
            insert con;
        }
        
        //step 3 ensure the future method runs before the assertion
        Test.startTest();
         AccountWithContacts.countContacts(new List<Id>{acc.Id});
        Test.stopTest();
        //step 3 query the contacts to check the total count
        Account updateAcc = [SELECT Id, Total_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id = :acc.Id];
        System.assertEquals(3, updateAcc.Total_Contacts__c, 'total contacts should be 3');
    }
}