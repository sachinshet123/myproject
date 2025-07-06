public class TestUndelete {
    public static void undeleteDemo() {
        List<Employee__c> deletedEmployees = [SELECT Id, Name, Account__c, LastModifiedDate FROM Employee__c WHERE IsDeleted = true ORDER BY LastModifiedDate DESC LIMIT 10 ALL ROWS];
        Set<Id> accIds = new Set<Id>();
        
        for(Employee__c emp : deletedEmployees) {
            System.debug(emp);
        }
    }
}