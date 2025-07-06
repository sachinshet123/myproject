global with sharing class SoapWebServiceCreateAcc {
    global class APIException extends Exception {
    }
    
    webservice static String getAPIStatus(String message) {
        return 'ready your response is ' + message;
    }
    webservice static String createAccount(String accName, String rating, Integer annualRevenue) {
        if(accName != null) {
            Account acc = new Account();
            acc.Name = accName;
            acc.Rating = rating;
            acc.AnnualRevenue = annualRevenue;
            insert acc;
            return acc.Id;
        } else {
            throw new APIException('error');
        }
    }
    
    webservice static String deleteAccount(String accId) {
       List<Account> delAccList = [SELECT Id FROM Account WHERE Id = :accId];
        if(delAccList.isEmpty()) {
            return 'please enter the account number to be deleted';
        } else {
            try {
                delete delAccList;
            } catch(Exception e) {
                return e.getMessage();
            }
            return 'Account Deleted Successfully';
        }
    } 
    
    webservice static String updateStatusOfAccountAndOpportunity(Integer annualRevenue, Integer amount) {
        List<Account> accList = [SELECT Id, Active__c FROM Account WHERE AnnualRevenue < : annualRevenue];
        for(Account acc : accList) {
            acc.Active__c = 'No';
        }
        
        List<Opportunity> oppList = [SELECT Id, StageName FROM Opportunity WHERE Amount < : amount];
        for(Opportunity opp : oppList) {
            opp.StageName = 'Closed Lost';
        }
        if(!oppList.isEmpty() && !accList.isEmpty()) {
            update oppList;
            update accList;
            return 'updated successfully';
        } else {
            throw new APIException('error');
        }
    }
}