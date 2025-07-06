public class ApexTriggerPractice {
    public static void method1() {
    List<Account> accList = new List<Account>();
    for(Integer i=1; i<=5; i++) {
        Account acc = new Account();
        acc.Name = 'bangalore' +i;
        acc.Phone = '5678';
        accList.add(acc);
    }
    insert accList;
    }
}