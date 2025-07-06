public class SOQLDemo1 {
    public static void insertAccount() {
        List<Account> listAcc = new List<Account>();
        List<Opportunity> listOpp = new List<Opportunity>();
        for(Integer i=1; i<=5; i++) {
            Account acc = new Account();
            acc.Name = 'Infosys '+i;
            listAcc.add(acc);
        }
        insert listAcc;
        for(Account acc : listAcc) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Opportunity for Infosys';
            Date myDate = Date.newInstance(2024, 12, 31);
            opp.CloseDate = myDate;
            opp.StageName = 'Prospecting';
            opp.AccountId = acc.Id;
            listOpp.add(opp);
        }
        insert listOpp;
    }
}