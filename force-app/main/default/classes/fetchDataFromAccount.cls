public with sharing class fetchDataFromAccount {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [
            SELECT Id, Name 
            FROM Account 
            WHERE CreatedDate = LAST_MONTH 
            ORDER BY CreatedDate DESC 
            LIMIT 20
        ];
    }
}