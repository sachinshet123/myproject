public with sharing class AccountWrapperDemo {
    @AuraEnabled(cacheable=true)
    public static List<AccountWrapper> getAccountWithContacts() {
        List<AccountWrapper> wrapList = new List<AccountWrapper>();
        
        List<Account> accList = [SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts) FROM Account ORDER BY CreatedDate DESC LIMIT 5];
        if(!accList.isEmpty()) {
            for(Account acc : accList) {
                if(!acc.Contacts.isEmpty()) {
                    wrapList.add(new AccountWrapper(acc, acc.Contacts));
                }
            }
        }
        return wrapList;
    }
    
    public class AccountWrapper {
        @AuraEnabled public Account accRecord { get; set; }
        @AuraEnabled public List<Contact> contactRecords { get; set; }
        public AccountWrapper(Account accRecord, List<Contact> contactRecords) {
            this.accRecord = accRecord;
            this.contactRecords = contactRecords;
        }
    }
}