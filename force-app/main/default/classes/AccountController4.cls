public with sharing class AccountController4 {
    @AuraEnabled
       public static void setObjectToRecentItems(Id recordId) {
           if (!String.isBlank(recordId)) {
               Schema.SObjectType sObjectType = recordId.getSobjectType();     
              //this query is selecting the Id and Name fields from a specified object where the 
               //Id matches a specific value, and it is being executed in a view context 
               //with dynamic object and record Id values.
   
               String queryString = String.format('SELECT Id, Name FROM {0} WHERE Id =: recordId FOR VIEW', new List<Object>{sObjectType});
               Database.query(queryString);
           }
       }
   }