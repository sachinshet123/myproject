public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getHighRevenueAccount(){
        try {
            return [SELECT Id, Name, AnnualRevenue FROM Account WHERE AnnualRevenue != NULL ORDER BY AnnualRevenue
            DESC LIMIT 5];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}