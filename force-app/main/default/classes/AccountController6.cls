public with sharing class AccountController6{
    @AuraEnabled(cacheable = true)
            public static List<SObject> FetchRecords(String SobjectName, String FieldsName){
                String query = 'select ' + FieldsName + ' From ' + SobjectName;
            try {
                List<SObject> fetchedRecord = Database.query(query);
                system.debug(fetchedRecord);
                return fetchedRecord;
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
    }