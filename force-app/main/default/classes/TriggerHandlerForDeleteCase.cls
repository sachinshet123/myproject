public class TriggerHandlerForDeleteCase {
    public static void callMethod(List<Case> caseList) {
        Set<Id> accountIds = new Set<Id>();
        
        for (Case cs : caseList) {
            if (cs.Origin == 'Web' && cs.AccountId != null) {
                accountIds.add(cs.AccountId);
            }
        }

        if (!accountIds.isEmpty()) {
            DeleteTheCaseIfTheOriginIsWeb.deleteTheCaseOriginIsWeb(new List<Id>(accountIds));
        }
    }
}