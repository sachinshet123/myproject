public class AccountFetcher {
    public static void fetchEnergyAccountsWithChildren() {
        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Contacts), (SELECT Id FROM Cases) FROM Account WHERE Industry = 'Energy'
        ];
        for(Account acc : accounts) {
            System.debug(acc.Contacts + ' ' + acc.Cases);
        }        
    }

}