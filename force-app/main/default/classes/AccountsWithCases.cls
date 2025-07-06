public class AccountsWithCases {
    @future
    public static void countContacts(List<Id> accIds) {
        System.debug('Execution started');

        // Query accounts and related cases
        List<Account> accList = [
            SELECT Id, Created_Email__c, Created_Web__c, Created_Phone__c,
                   (SELECT Id, Origin FROM Cases)
            FROM Account
            WHERE Id IN :accIds
        ];

        List<Account> accountsToUpdate = new List<Account>();

        // Count case origins and set custom fields
        for (Account acc : accList) {
            Integer phone = 0;
            Integer email = 0;
            Integer web = 0;

            for (Case cs : acc.Cases) {
                if (cs.Origin == 'Phone') {
                    phone++;
                } else if (cs.Origin == 'Email') {
                    email++;
                } else if (cs.Origin == 'Web') {
                    web++;
                }
            }

            acc.Created_Email__c = email;
            acc.Created_Phone__c = phone;
            acc.Created_Web__c = web;

            accountsToUpdate.add(acc); // ✅ Add to update list
        }

        // Perform DML operation only if needed
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }

        System.debug('Execution ended');
    }
}