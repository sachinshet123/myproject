public class AccountWithContacts {
	@future
    public static void countContacts(List<Id> accIds) {
        System.debug('execution started');
        List<Account> accList = [SELECT Id, Total_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accIds];
        List<Account> accountsToUpdate = new List<Account>();
        if(!accList.isEmpty()) {
            for(Account acc : accList) {
                acc.Total_Contacts__c = acc.Contacts.size();
                accountsToUpdate.add(acc);
            }
        }
        //perform DML operation
        if(!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
        System.debug('execution ended');
    }
}