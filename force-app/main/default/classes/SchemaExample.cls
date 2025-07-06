public class SchemaExample {
    public static void getAllObjects() {
        Map<String, Schema.SObjectType> objectMap = Schema.getGlobalDescribe();
        for(String objectName : objectMap.keySet()) {
            System.debug('Object Name ' + objectName);
        }
    }
    public static void getObjectFields(String objectName) {
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        if(globalDescribe.containsKey(objectName)) {
        Schema.DescribeSObjectResult objDescribe = globalDescribe.get(objectName).getDescribe();
            Map<String, SObjectField> objFields = objDescribe.fields.getMap();
            for(String field : objFields.keySet()) {
                System.debug('Field Name ' + field);
            }
        } else {
            System.debug('Object not found');
        }
    }
    public static void getObjectFieldTypeAndAttributes(String objectName, String fieldName) {
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        if(globalDescribe	.containsKey(objectName)) {
        Schema.DescribeSObjectResult objDescribe = globalDescribe.get(objectName).getDescribe();
        
            Map<String, SObjectField> objectFields = objDescribe.fields.getMap();
            
            if(objectFields.containsKey(fieldName)) {
        		Schema.DescribeFieldResult fieldDescribe = objectFields.get(fieldName).getDescribe();     
                System.debug('Field Label ' + fieldDescribe.getLabel());
                System.debug('Field Type ' + fieldDescribe.getType());
                System.debug('Field Length ' + fieldDescribe.getlength());
                System.debug('Field Is Nillable ' + fieldDescribe.isNillable()); // field is mandatory
            } else {
                System.debug('Field attributes not found');
            }
        } else {
            System.debug('Object not found');
        }
    }
}