@RestResource(urlMapping='/accmagt/')
global with sharing class AccMagt {
	/*@HttpGet
    global static List<Account> getTopAcc() {
        List<Account> accList = [SELECT Id, Name, AnnualRevenue FROM Account WHERE AnnualRevenue != null];
        return accList;
    }
    
    @HttpGet
    global static List<Account> getAccountsByIndustry() {
        //Read the industry parameter from the querystring
        String industryFilter = RestContext.request.params.get('Industry');
        List<Account> accList = [SELECT Id, Name, AnnualRevenue FROM Account WHERE Industry =: industryFilter];
        return accList;
    }
    // fetch accounts with related contacts and cases where account industry is energy
    
    @HttpGet
    global static List<Account> getAccountContactsByIndustry() {
    String industryFilter = RestContext.request.params.get('Industry');
    List<Account> accList = [SELECT Id, Name, (SELECT Id, Name FROM Contacts), (SELECT Id FROM Cases) FROM Account WHERE Industry = :industryFilter ];
    return accList;
    }
    //using wrapper class
    
    @HttpGet
    global static AccountWrapper getAccountsApex() {
        
    	String industryFilter = RestContext.request.params.get('Industry');
        List<Account> accList = [SELECT Id, Name, AnnualRevenue, Industry FROM Account WHERE Industry = : industryFilter];
        List<Id> accIds = new List<Id>();
        for(Account acc : accList) {
            accIds.add(acc.Id);
        }
        List<Contact> conList = [SELECT Id, Name FROM Contact WHERE AccountId IN : accIds];
        List<Case> caseList = [SELECT Id FROM Case WHERE AccountId IN : accIds];
        
        AccountWrapper accWrapper = new AccountWrapper();
        accWrapper.accList = accList;
        accWrapper.conList = conList;
        accWrapper.caseList = caseList;
        return accWrapper;
        
    }
    global class AccountWrapper {
        global List<Account> accList;
        global List<Contact> conList;
        global List<Case> caseList;
    }
    
    @HttpPost
    global static String createAccount(String accName, String phone, String accRating, String accIndustry) {
        Account acc = new Account();
        acc.Name = accName;
        acc.Phone = phone;
        acc.Rating = accRating;
        acc.Industry = accIndustry;
        try {
            insert acc;
            return 'inserted successfully';
        }
        catch(Exception e) {
            return e.getMessage();
        }
    }
    
    
    global class AccountInfo {
        global Account accRecord { get; set; }
        global Contact conRecord { get; set; }
    }
    @HttpPost
    global static String createAccountWithContact(AccountInfo accInfo) {
        Account accRec = accInfo.accRecord;
        Contact conRec = accInfo.conRecord;
        try {
            insert accRec;
            conRec.AccountId = accRec.Id;
            insert conRec;
            return 'Account and Contact created';
        }
        catch(Exception e) {
            return e.getMessage();
        }
    }


	@HttpDelete
    global static String deleteAccount() {
        List<Account> delAccList = [SELECT Id FROM Account WHERE Name = 'SVS'];
        try {
            delete delAccList;
            return 'deleted successfully';
        }
        catch(Exception e) {
            return e.getMessage();
        }
    }  */
    
    @HttpDelete
    global static String deleteListOfAccounts() {
        String accIds = RestContext.request.params.get('accIds');
        List<String> accIdString = accIds.split(',');
        List<Account> delAccList = [SELECT Id FROM Account WHERE Id IN : accIdString];
        try {
            delete delAccList;
            return 'Deleted Successfully';
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}