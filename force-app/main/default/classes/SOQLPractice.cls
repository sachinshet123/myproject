public class SOQLPractice {
    public static void queryAccThisWeek() {
        List<Account> listAcc = new List<Account>([SELECT Id, Name, createdDate FROM Account WHERE createdDate = LAST_WEEK]);
        System.debug('last week accounts');
        for(Account acc : listAcc) {
            System.debug(acc);
        }
        List<Account> listAcc1 = new List<Account>([SELECT Id, Name, createdDate FROM Account WHERE createdDate =THIS_WEEK]);
        System.debug('this week accounts');
        for(Account acc : listAcc1) {
            System.debug(acc);
        }
        List<Contact> listCon2 = new List<Contact>([SELECT Id, Name, createdDate FROM Contact WHERE createdDate = LAST_WEEK]);
        System.debug('last week contacts');
        for(Contact con : listCon2) {
            System.debug(con);
        }
        List<Contact> listCon3 = new List<Contact>([SELECT Id, Name, createdDate FROM Contact WHERE createdDate = THIS_WEEK]);
        System.debug('this week contacts');
        for(Contact con : listCon3) {
            System.debug(con);
        }
		List<Account> listAcc4 = new List<Account>([SELECT Id, Name, createdDate, (SELECT Id, Name, createdDate FROM ContactS) FROM Account WHERE createdDate = LAST_FISCAL_YEAR]);
        System.debug(listAcc4);
        System.debug('hello');
    }
}