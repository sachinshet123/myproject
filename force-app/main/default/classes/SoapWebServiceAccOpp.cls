global with sharing class SoapWebServiceAccOpp {
    global class APIException extends Exception {}
    
    webservice static String getAPIStatus(String message) {
        return 'ready your message is ' + message;
    }
    webservice static List<Account> getAccWithOppDetail(String searchValue) {
        if(searchValue != null) {
            List<Account> accList = [SELECT Id, Name, Rating, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Rating = : searchValue];
            return accList;
        } else {
            throw new  APIException('error');
        }
    }
}