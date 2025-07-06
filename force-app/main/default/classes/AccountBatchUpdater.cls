public class AccountBatchUpdater implements Database.Batchable<sObject>, Database.AllowsCallouts {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        for(Account acc : scope) {
            acc.Rating = 'Hot';
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc) {
        // You can perform any post-processing tasks here
    }
    // Method to update all accounts
    @AuraEnabled
    public static void updateAllAccounts() {
        Database.executeBatch(new AccountBatchUpdater());
    }

}