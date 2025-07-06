public with sharing class ImperativeApproachAccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getHighRevenueAccount(Integer count){
        try {
            return [SELECT Id, Name, AnnualRevenue FROM Account LIMIT : count];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}