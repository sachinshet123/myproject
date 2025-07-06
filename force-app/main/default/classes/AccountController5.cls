public with sharing class AccountController5 {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [
            SELECT Id, Name, Phone, AnnualRevenue, Website
            FROM Account
            WITH SECURITY_ENFORCED
            LIMIT 10
        ];
    }
}