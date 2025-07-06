public with sharing class CreateRecord {
    @AuraEnabled (cacheable=true)
      public static List<Contact> FetchConRec(){
          return[SELECT id,name,email,phone,title FROM Contact LIMIT 5000];
      }
  }