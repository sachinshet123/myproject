public class SOQLClass {
    public static void run() {
        List<Account> listAccount = new List<Account>();
listAccount = [SELECT Id, Name FROM Account];
System.debug(listAccount);
    }
}