public class CreateSetOfAccountIds {
    public static void createSetOfAccountIdsMethod() {
        Set<Account> accSet = new Set<Account>([SELECT Id, Name FROM Account LIMIT 5]);
        Set<Id> idSet = new Set<Id>();
        Map<Id, Opportunity> mapAcc = new Map<Id, Opportunity>([SELECT Id, Name FROM Opportunity LIMIT 5]);
        System.debug(mapAcc);
        for(Id ids : mapAcc.keySet()) {
            System.debug(mapAcc.get(ids));
        }
        
        for(Opportunity opp : mapAcc.values()) {
            System.debug(opp);
        }
        System.debug(accSet);
        for(Account acc : accSet) {
            idSet.add(acc.id);
        }
        System.debug(idSet);
    }
}