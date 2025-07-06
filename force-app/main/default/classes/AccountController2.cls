public with sharing class AccountController2{
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountData() {
        return [SELECT Id,Name,(Select Id,Name,FirstName,LastName,Email,Phone from Contacts) from Account];
    }
}