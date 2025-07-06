public class MapWithCollections {
    public static void collectionMethods() {
        List<String> colors = new List<String>();
        colors.add('red');
        colors.add('green');
        colors.add('orange');
        System.debug(colors);
        
        for(String color:colors) {
            System.debug(color);
        }
    }
    
    public static void loopOnObjectList() {
        List<Account> accList = new List<Account>();
        accList = [SELECT Id, Name, Phone from Account LIMIT 5];
        System.debug(accList);
        for(Account acc : accList) {
            System.debug(acc);
        }
    }
    public static void loopOnTest() {
        List<Account> accList1 = new List<Account>();
        accList1 = [SELECT Id, Name from Account LIMIT 5];
        Set<Id> setId = new Set<Id>();
        for(Account acc : accList1) {
            setId.add(acc.Id);
        }
        for(Id ids : setId) {
            System.debug(ids);
        }
    }
    public static void iterateAccountMap() {
        List<Account> accList2 = new List<Account>();
        	Map<Id, Account> mapIdAcc = new Map<Id, Account>();
        	accList2 = [SELECT Id, Name from Account LIMIT 5];
        for(Account acc : accList2) {
            mapIdAcc.put(acc.Id, acc);
        }
        if(!mapIdAcc.isEmpty()) {
             for(Id key : mapIdAcc.keySet()) {
            System.debug('key is' + key + 'value is' + mapIdAcc.get(key));
            System.debug(key);
        }
        }
       
        
        for(Account value : mapIdAcc.values()) {
            System.debug('value is ' +value);
        }
    }
}