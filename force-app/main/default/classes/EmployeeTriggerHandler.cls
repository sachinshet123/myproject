public class EmployeeTriggerHandler {
    // Method to update the Left_Employee_Count__c field on related Accounts when Employees are deleted
    public static void leftEmployeeCount(List<Employee__c> oldEmpList) {
        // Collect Account IDs from the deleted Employee records
        Set<Id> accIds = new Set<Id>();
        for (Employee__c emp : oldEmpList) {
            if (emp.Account__c != null) {
                accIds.add(emp.Account__c);
            }
        }
        // If no Account IDs are found, exit early
        if (accIds.isEmpty()) return;
        // Query existing Accounts and prepare a map of Account IDs to current Left_Employee_Count__c
        Map<Id, Account> accIdToAccMap = new Map<Id, Account>(
            [SELECT Id, Left_Employee_Count__c FROM Account WHERE Id IN :accIds]
        );
        
        // Prepare Account records for update with incremented counts
        List<Account> accountsToUpdate = new List<Account>();	
        for (Employee__c emp : oldEmpList) {
            if (emp.Account__c != null && accIdToAccMap.containsKey(emp.Account__c)) {
                Account acc = accIdToAccMap.get(emp.Account__c);
                acc.Left_Employee_Count__c = (acc.Left_Employee_Count__c != null ? acc.Left_Employee_Count__c : 0) + 1;
                if (!accountsToUpdate.contains(acc)) {
                    accountsToUpdate.add(acc);
                }
            }
        }
        // Update the Accounts if any changes were made
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
    public static void reduceTheLeftEmployeeCount(List<Employee__c> newEmpList) {
        // Map to track the count of restored employees per Account
        Map<Id, Integer> accountToRestoreCount = new Map<Id, Integer>();
        
        // Iterate through the restored Employee records
        for (Employee__c emp : newEmpList) {

            // Count restored employees for each related Account
            if (emp.Account__c != null) {
                if (!accountToRestoreCount.containsKey(emp.Account__c)) {
                    accountToRestoreCount.put(emp.Account__c, 0);
                }
                accountToRestoreCount.put(emp.Account__c, accountToRestoreCount.get(emp.Account__c) + 1);
            }
        }
        
        // List to store Account records to update
        List<Account> accountsToUpdate = new List<Account>();
        
        // Query related Account records
        if (!accountToRestoreCount.isEmpty()) {
            Map<Id, Account> accountMap = new Map<Id, Account>(
                [SELECT Id, Left_Employee_Count__c FROM Account WHERE Id IN :accountToRestoreCount.keySet()]
            );
            
            // Update the Left_Employee_Count__c field on related Accounts
            for (Id accountId : accountToRestoreCount.keySet()) {
                if (accountMap.containsKey(accountId)) {
                    Account acc = accountMap.get(accountId);
                    acc.Left_Employee_Count__c = (acc.Left_Employee_Count__c != null ? acc.Left_Employee_Count__c : 0) - accountToRestoreCount.get(accountId);
                    if (acc.Left_Employee_Count__c < 0) {
                        acc.Left_Employee_Count__c = 0; // Ensure the count does not go below zero
                    }
                    accountsToUpdate.add(acc);
                }
            }
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate; // Update Account records
        }
    }
    public static void shareEmployeeRecords(List<Employee__c> newEmployees) {
        // Query users with the Standard User profile
        List<User> standardUsers = [SELECT Id FROM User WHERE Profile.Name = 'Standard User'];

        if (standardUsers.isEmpty()) {
            System.debug('No users found with Standard User profile.');
            return;
        }

        // Create Employee__Share records
        List<Employee__Share> employeeShares = new List<Employee__Share>();
        for (Employee__c emp : newEmployees) {
            for (User user : standardUsers) {
                Employee__Share share = new Employee__Share();
                share.ParentId = emp.Id;            // Record to be shared
                share.UserOrGroupId = user.Id;      // User receiving the share
                share.AccessLevel = 'Edit';        // Share access level ('Read' or 'Edit')
                share.RowCause = Schema.Employee__Share.RowCause.Manual; // Reason for sharing
                employeeShares.add(share);
            }
        }

        // Insert the sharing records
        if (!employeeShares.isEmpty()) {
            try {
                insert employeeShares;
                System.debug('Employee records shared successfully.');
            } catch (Exception e) {
                System.debug('Error while sharing Employee records: ' + e.getMessage());
            }
        }
    }
}