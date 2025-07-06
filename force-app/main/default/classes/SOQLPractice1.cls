public class SOQLPractice1 {
    public static void listAccounts() {
        String variable = 'Customer - Channel';
        List<Account> listAcc = new List<Account>([SELECT Id, Name FROM Account WHERE Type=:variable LIMIT 3]);
        for(Account acc : listAcc) {
            System.debug(acc);
        }
    }
}