public class ToggleFeatureCustom {
    public static void createContacts(List<Account> newAccList) {
        List<Contact> conList = new List<Contact>();
        for(Account acc : newAccList) {
            Contact con = new Contact();
            con.LastName = 'contact' + acc.Name;
            con.AccountId = acc.Id;
            conList.add(con);
        }
        if(!conList.isEmpty()) {
            insert conList;
        }
    }
}