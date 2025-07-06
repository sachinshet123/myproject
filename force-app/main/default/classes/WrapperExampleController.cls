public class WrapperExampleController {
    public List<AccountContactWrapper> accountContactList { get; set; }

    public WrapperExampleController() {
        accountContactList = new List<AccountContactWrapper>();

        // Fetch Accounts (Stored in a List, No Need for Map)
        List<Account> accounts = [SELECT Id, Name FROM Account ORDER BY CreatedDate DESC LIMIT 5];

        // Fetch Contacts (Bulkified Query)
        Map<Id, Contact> accountContactMap = new Map<Id, Contact>();
        List<Contact> contacts = [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE AccountId IN :accounts];

        // Populate the Map for Quick Lookup
        for (Contact con : contacts) {
            accountContactMap.put(con.AccountId, con);
        }

        // Create Wrapper Objects
        for (Account acc : accounts) {
            Contact con = accountContactMap.get(acc.Id);  // Get related Contact
            accountContactList.add(new AccountContactWrapper(acc, con));
        }
    }
}