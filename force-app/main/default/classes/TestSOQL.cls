public class TestSOQL {
    public static void testQuery() {
     List<Account> accountsWithContacts = [SELECT Id, Name, CreatedDate, 
                                      (SELECT Id, FirstName, LastName, Email, CreatedDate 
                                       FROM Contacts) 
                                      FROM Account 
                                      WHERE CreatedDate = LAST_WEEK];

for (Account acc : accountsWithContacts) {
    System.debug('Account Name: ' + acc.Name + ', Created Date: ' + acc.CreatedDate);

    // Loop through associated contacts
    for (Contact con : acc.Contacts) {
        System.debug('  Contact Name: ' + con.FirstName + ' ' + con.LastName + 
                     ', Email: ' + con.Email + ', Created Date: ' + con.CreatedDate);
    }
}


    }
}