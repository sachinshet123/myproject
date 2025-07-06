public with sharing class AccountController1{
    @AuraEnabled(cacheable=true)
  public static List<Account> searchAccounts(String searchTerm) {
      String strKey = '%'+searchTerm+'%';
      List<Account> blanklist = new List<Account>();
       if (String.isNotBlank(searchTerm)) {
      List<Account> newacclist= [SELECT Id, Name FROM Account WHERE Name LIKE :strKey];
           return newacclist;
       }
      else{
          return blanklist;
      }
  }
  @AuraEnabled
  public static void updateAccount(Account account) {
      update account;
  }
}