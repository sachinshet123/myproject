public class DeleteTheCaseIfTheOriginIsWeb {
	@future
    public static void deleteTheCaseOriginIsWeb(List<Id> accIds) {
        try {
            
        //step 1 get the account
        List<Account> accList = [SELECT Id, (SELECT Id, Origin FROM Cases) FROM Account WHERE Id = :accIds];
        List<Case> caseList = new List<Case>();
        
        //step 2 get the cases with orgin web
        if(!accList.isEmpty()) {
            for(Account acc : accList) {
            for(Case cs : acc.Cases) {
                if(cs.Origin == 'Web') {
                    caseList.add(cs);
                }
            }
        }
        if(!caseList.isEmpty()) {
                    delete caseList;
          }
        }
        } catch(Exception e) {
            System.debug('Error is ' + e.getMessage());
        }
    }
}