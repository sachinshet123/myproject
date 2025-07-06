public class ApexProgramming {
     public static void method1() {
        List<Account> listAcc = new List<Account>();
        listAcc = [SELECT Id, Name FROM Account LIMIT 5];
        Set<Id> setId = new Set<Id>();
        for(Account acc : listAcc) {
            setId.add(acc.id);
        }
        System.debug(setId);
    }
    public static void method23() {
        List<Account> listAcc = new List<Account>([SELECT Id, Name FROM Account LIMIT 5]);
        Map<Id, Account> mapAcc = new Map<Id, Account>();
        for(Account acc : listAcc) {
            mapAcc.put(acc.id, acc);
        }
        System.debug(mapAcc);
        for(Id ids : mapAcc.keySet()) {
            System.debug(mapAcc.get(ids));
        }
        Map<Id, Account> mapAcc1 = new Map<Id, Account>([SELECT Id, Name FROM Account LIMIT 5]);
        System.debug(mapAcc1);
    }
    public static void method4() {
        
        List<Account> listAcc = new List<Account>([SELECT Id, Name FROM Account LIMIT 5]);
        Set<Id> listSet = new Set<Id>();
        Map<Id, Account> mapAcc = new Map<Id, Account>();
        for(Account acc : listAcc) {
            listSet.add(acc.id);
            mapAcc.put(acc.id, acc);
        }
        for(Id i : listSet) {
            if(mapAcc.containsKey(i)) {
                System.debug(mapAcc.get(i));
            }
        }
    }
    public static void method5() {
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE createdDate=THIS_WEEK]);
        System.debug('this week ' +accList);
        List<Account> accList1 = new List<Account>([SELECT Id, Name FROM Account WHERE createdDate=LAST_WEEK]);
        System.debug('last week ' +accList1);
        
        List<Contact> conList = new List<Contact>([SELECT Id, Name FROM Contact WHERE createdDate=THIS_WEEK]);
        System.debug('this week ' +conList);
        List<Contact> conList1 = new List<Contact>([SELECT Id, Name FROM Contact WHERE createdDate=LAST_WEEK]);
        System.debug('last week ' +conList1);
    }
    public static void method6() {
        List<Account> listAcc = new List<Account>([SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE createdDate=LAST_WEEK]);
        System.debug('last week accounts with related contacts' +listAcc);
        List<Account> listAcc1 = new List<Account>([SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE createdDate=THIS_WEEK]);
        System.debug('this week accounts with related contacts' +listAcc1);
        List<Account> listAcc2 = new List<Account>([SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE createdDate=THIS_YEAR]);
        for(Account acc : listAcc2) {
            System.debug(acc);
        }
    }
    public static void method7() {
        List<AggregateResult> aggRes= [SELECT count(Name), count(Phone) FROM Account];
        for(AggregateResult ag : aggRes) {
            System.debug('ag 0' +ag.get('expr0'));
            System.debug('ag 1' +ag.get('expr1'));
        }
    }
    public static void method8() {
        List<Account> listAcc = new List<Account>([SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Phone!=null]);
        //System.debug(listAcc);
 
    
    for(Account acc : listAcc) {
        for(Contact con : acc.Contacts) {
            System.debug('Contact id is ' +con.Id);
            System.debug('Contact name is ' +con.Name);
        }
    	}
    }
    public static void method9() {
        List<Account> listAcc = new List<Account>([SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Phone != null]);
        for(Account acc : listAcc) {
            System.debug(acc.Name + ' has ' + acc.Contacts.size() + ' related records');
        }
        // other straight queries as below
        // SELECT Account.Name, count(Id) FROM Contact WHERE Account.Phone != null GROUP BY Account.Name
        
    }
    public static void method10() {
        List<Account> listAcc = new List<Account>([SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Phone != null]);
        for(Account acc : listAcc) {
            System.debug(acc.Name + ' has ' + acc.Opportunities.size() + ' related records');
        }
        // other straight queries as below
        // SELECT Account.Name, count(Id) FROM Opportunity WHERE Account.Phone != null GROUP BY Account.Name
    }
    public static void method11() {
        Account acc1 = new Account();
        acc1.Name = 'person 100';
        insert acc1;
        Account acc2 = new Account();
        acc2.Name = 'person 101';
        insert acc2;
        List<Account> listAcc = new List<Account>();
        for(Integer i=1; i<=2; i++) {
            Account acc = new Account();
            acc.Name = 'person200'+i;
            listAcc.add(acc);
        }
        insert listAcc;
    }
    public static void method12() {
        Account acc = new Account();
        acc.Name = 'Valtech';
        //insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName ='employee 1';
        
        Contact con1 = new Contact();
        con1.AccountId = acc.Id;
        con.LastName ='employee 2';
        
        List<Contact> conList = new List<Contact>();
        conList.add(con);
        conList.add(con1);
        System.debug(conList);
        //List<Database.SaveResult> srList = Database.insert(conList, false);
    }
    
    
    public static void method13() {
        System.debug([SELECT count(Id), count(Name) FROM Account]);
        System.debug([SELECT Id, Name FROM Account]);
        
    }
    public static void method14() {
        List<Account> listAcc =new  List<Account>();
        for(Integer i=1; i <=5; i++) {
            Account acc = new Account();
            acc.Name = 'Person '+i;
            acc.Phone = '9880403878';
            listAcc.add(acc);
        }
        insert listAcc;
    }
    public static void method15() {
        List<Opportunity> listOpp =new  List<Opportunity>();
        for(Integer i=1; i <=5; i++) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Person '+i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.today();
            listOpp.add(opp);
        }
        insert listOpp;
    }
    public static void method16() {
        Account acc = new Account();
        acc.Name = 'Lara Technologies';
        insert acc;
        Contact con = new Contact();
        con.LastName = 'Shet';
        con.AccountId = acc.Id;
        insert con;
    }
    public static void method17() {
		Account acc = new Account(Name = 'Reliance');
        insert acc;
        Contact con = new Contact();
        con.LastName = 'Jio';
        con.AccountId = acc.id;
        insert con;
        Opportunity opp = new Opportunity();
        opp.Name = 'Valtech';
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();
        opp.AccountId = acc.id;
        insert opp;
    }
    public static void updateAccounts(String phonenumber) {
        List<Account> listAcc = new List<Account>([SELECT Id, Name FROM Account WHERE Phone =: phonenumber]);
        if(!listAcc.isEmpty()) {
         for(Account acc : listAcc) {
            acc.Phone = '2222222222';
        	}   
        }
        Account acc = new Account();
        acc.Name = 'Robert Bosch';
        listAcc.add(acc);
        upsert listAcc;
    }
    public static void updateOpportunities() {
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id, Name FROM Opportunity WHERE Amount = NULL AND StageName NOT IN ('Closed Won', 'Closed Lost')]);
        if(!oppList.isEmpty()) {
         for(Opportunity opp : oppList) {
            opp.Amount = 10000;
        	}   
        }
        for(Integer i =1; i<=5; i++) {
            Opportunity opp = new Opportunity();
            opp.Name ='Person1 ' +i;
            opp.CloseDate=Date.today();
            opp.StageName='Prospecting';
            oppList.add(opp);
        }
        try {
            upsert oppList;
        }
        catch(Exception e) {
            System.debug(e.getMessage());
        }
        
    }
    public static void method34() {
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id, Name FROM Opportunity WHERE Amount = NULL AND StageName NOT IN ('Closed Won', 'Closed Lost')]);
        delete oppList;
    }
    public static void method35() {
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE IsDeleted = TRUE ALL ROWS]);
        undelete accList;
    }
	public static void method36() {
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id, Name FROM Opportunity WHERE IsDeleted = TRUE ALL ROWS]);
        Database.emptyRecycleBin(oppList);
    }
    //List<List<SObject>> searchList = [FIND 'sachin' IN ALL FIELDS RETURNING Account(Name), Contact(LastName)];
	//for(SObject sobj : searchList[0]) {
    //Account acc = (Account)sobj;
    //System.debug(acc.Name);
    //List<List<SObject>> searchList = [FIND 'sachin' IN ALL FIELDS RETURNING Account(Name), Contact(LastName)];
	//List<Account> accList = (List<Account>)searchList[0];
	//List<Contact> conList = (List<Contact>)searchList[1];
	//for(Account acc : accList) {
	//    System.debug(acc.Name);
	//}
	//for(Contact con : conList) {
	//    System.debug(con.LastName);
	//}
	//}
    public static void method100() {
        System.debug('Good Morning');
    }
    public static void method101() {
        System.debug('Good Night');
    }
    public static void method015() {
        Account acc = new Account();
        acc.Name = 'Lara Technology';
        insert acc;
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Shet';
        insert con;
    }
    public static void method016() {
        Account acc = new Account();
        acc.Name = 'RNS Polytechnic';
        insert acc;
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'Principal';
        insert con;
        Opportunity opp = new Opportunity();
        Date closeDate = Date.newInstance(2024, 12, 31);
        opp.Name = 'Student 1';
        opp.CloseDate = closeDate;
        opp.StageName = 'Prospecting';
        opp.AccountId = acc.Id;
        insert opp;
    }
    public static void method017() {
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Integer i=1; i<=5; i++) {
            Account acc = new Account();
            acc.Name = 'Asian Paints ' +i;
            accList.add(acc);
        }
        try {
            insert accList;
        }
        catch(Exception e) {
            System.debug('Error occured during inserting account list ' +e.getMessage());
        }
        
        for(Account acc : accList) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Sirsi';
            opp.CloseDate = Date.today();
            opp.StageName = 'Prospecting';
            opp.AccountId = acc.id;
            oppList.add(opp);
        }
        try {
            insert oppList;
        }
        catch(Exception e) {
            System.debug('Error occured during inserting opportunity list ' +e.getMessage());
        }
    }
    
    //by using database classes
    public static void method017a() {
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Integer i=1; i<=5; i++) {
            Account acc = new Account();
            acc.Name = 'Asian Paints ' +i;
            accList.add(acc);
        }
        List<Database.SaveResult> results1 = Database.insert(accList, false);
        for(Database.SaveResult result : results1) {
            if(result.isSuccess()) {
                System.debug('account records inserted successfully ' +result.getId());
            }
            else {
                for(Database.Error error : result.getErrors()) {
                    System.debug('account error message is ' +error.getMessage());
                    System.debug('account error field is ' +error.getFields());
                    System.debug('account error status code is ' +error.getStatusCode());
                }
            }
        }
        
        for(Account acc : accList) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Sirsi';
            opp.CloseDate = Date.today();
            opp.StageName = 'Prospecting';
            opp.AccountId = acc.id;
            oppList.add(opp);
        }
        List<Database.SaveResult> results2 = Database.insert(oppList, false);
        for(Database.SaveResult result : results2) {
            if(result.isSuccess()) {
                System.debug('account records inserted successfully ' +result.getId());
            }
            else {
                for(Database.Error error : result.getErrors()) {
                    System.debug('account error message is ' +error.getMessage());
                    System.debug('account error field is ' +error.getFields());
                    System.debug('account error status code is ' +error.getStatusCode());
                }
            }
        }
    }
    public static void method018() {
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=1; i<=5; i++) {
            Account acc = new Account();
            acc.Name = 'India';
            accList.add(acc);
        }
        if(!accList.isEmpty()) {
            try {
            insert accList;
        	}
        catch(Exception e) {
            System.debug('the error happened in inserting account is ' +e.getMessage());
        	}
        }
        for(Account acc : accList) {
            Contact con = new Contact();
            con.LastName = 'Karnataka';
            con.AccountId = acc.Id;
            conList.add(con);
            Opportunity opp = new Opportunity();
            opp.Name = 'Maharashtra';
            Date myDate = Date.newInstance(2024, 12, 31);
            opp.CloseDate = myDate;
            opp.StageName = 'Qualification';
            opp.AccountId = acc.id;
            oppList.add(opp);
        }
        if(!conList.isEmpty()) {
            try {
            insert conList;
        	}
        catch(Exception e) {
            System.debug('error occured during insertion of contacts is' +e.getMessage());
        	}
        }
        if(!oppList.isEmpty()) {
            try {
            insert oppList;
        	}
        catch(Exception e) {
            System.debug('error occured during insertion of opportunity is ' +e.getMessage());
        	}
        }
    }
    public static void method019() {
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE Phone = NULL]);
        for(Account acc : accList) {
            acc.Phone = '716';
        }
        if(!accList.isEmpty()) {
            try {
                update accList;
            }
            catch(Exception e) {
                System.debug('Account records have error message ' +e.getMessage());
            }
        }
    }
    public static void method019a() {
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE Phone = NULL]);
        for(Account acc : accList) {
            acc.Phone = '716';
        }
        List<Database.SaveResult> result = Database.update(accList, false);
        for(Database.SaveResult res : result) {
            if(res.isSuccess()) {
                System.debug('Account records updated successfully' +res.getId());
            }
            else {
                for(Database.Error err : res.getErrors()) {
                    System.debug('Error message is ' +err.getMessage());
                    System.debug('Error fields are ' +err.getFields());
                    System.debug('Error status code are ' +err.getStatusCode());
                }
            }
        }
    }
    public static void method020() {
        List<Contact> conList = new List<Contact>([SELECT Id, Name FROM Contact WHERE Email = NULL]);
        for(Contact con : conList) {
            con.Email = 'test@test.com';
        }
        List<Database.SaveResult> result = Database.update(conList, false);
        for(Database.SaveResult res : result) {
            if(res.isSuccess()) {
                System.debug('Account records updated successfully' +res.getId());
            }
            else {
                for(Database.Error err : res.getErrors()) {
                    System.debug('Error message is ' +err.getMessage());
                    System.debug('Error fields are ' +err.getFields());
                    System.debug('Error status code are ' +err.getStatusCode());
                }
            }
        }
    }
    public static void method021() {
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE Phone = '12']);
        for(Account acc : accList) {
            acc.Phone = '11';
        }
        for(Integer i=1; i <=5; i++) {
            Account acc = new Account();
            acc.Name = 'Sun Pharma';
            accList.add(acc);
        }
        if(!accList.isEmpty()) {
            try {
                upsert accList;
            }
            catch(Exception e) {
                System.debug('error message is ' +e.getMessage());
            }
        }
    }
    public static void method021a() {
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE Phone = '11']);
        for(Account acc : accList) {
            acc.Phone = '1111';
        }
        for(Integer i=1; i <=5; i++) {
            Account acc = new Account();
            acc.Name = 'Sun Pharma';
            accList.add(acc);
        }
        List<Database.UpsertResult> result = Database.upsert(accList, false);
        for(Database.UpsertResult res : result) {
            if(res.isSuccess()) {
                System.debug('Account records updated successfully' +res.getId());
            }
            else {
                for(Database.Error err : res.getErrors()) {
                    System.debug('Error message is ' +err.getMessage());
                    System.debug('Error fields are ' +err.getFields());
                    System.debug('Error status code are ' +err.getStatusCode());
                }
            }
        }
    }
    public static void method22() {
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id, Name FROM Opportunity WHERE createdDate = LAST_MONTH]);
        for(Opportunity opp : oppList) {
            opp.StageName = 'Closed Won';
        }
        for(Integer i=1; i<=5; i++) {
            Opportunity opp = new Opportunity();
            opp.Name = 'RNS';
            opp.CloseDate = Date.today();
            opp.StageName = 'Closed Won';
            oppList.add(opp);
        }
        if(!oppList.isEmpty() && oppList !=NULL) {
            try {
                upsert oppList;
            }
            catch(Exception e) {
                System.debug('exception error is ' +e.getMessage());
            }
        }
    }
    public static void method023() {
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE Phone = '1115']);
        if(accList != NULL && !accList.isEmpty()) {
            try {
                delete accList;
            }
            catch(Exception e) {
                System.debug('deleted successfully' +e.getMessage());
            }
        }
    }
    public static void method023a() {
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE Phone = '100']);
        //System.debug(Database.delete(accList, false));
        if(accList != NULL && !accList.isEmpty()) {
            List<Database.DeleteResult> delResult = Database.delete(accList, false);
            for(Database.DeleteResult dr : delResult) {
                if(dr.isSuccess()) {
                    System.debug('deleted successfully ' +dr.getId());
                }
                else {
                    for(Database.Error err : dr.getErrors()) {
                        System.debug('Error fields' +err.getFields());
                        System.debug('error message' +err.getMessage());
                        System.debug('status code' +err.getStatusCode());
                    }
                }
            }
        }
    }
    public static void method24() {
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE Phone = '100' AND isDeleted = TRUE ALL ROWS]);
        if(!accList.isEmpty() && accList != NULL) {
            try {
                undelete accList;
            }
            catch(Exception e) {
                System.debug('error message is' +e.getMessage());
            }
        }
    }
    public static void method25() {
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id, Name FROM Opportunity WHERE StageName = 'Closed Won' AND createdDate = LAST_MONTH]);
        if(!oppList.isEmpty() && oppList != NULL) {
            try {
                delete oppList;
            }
            catch(Exception e) {
                System.debug('error message is' +e.getMessage());
            }
        }
    }
    public static void method26() {
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE createdDate = LAST_WEEK]);
        //System.debug(accList);
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc : accList) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Sachin Shet';
            opp.CloseDate = Date.today();
            opp.StageName = 'Closed Won';
            opp.AccountId = acc.Id;
            oppList.add(opp);
        }
        if(!oppList.isEmpty() && oppList != NULL) {
            try {
                insert oppList;
            }
            catch(Exception e) {
                System.debug('error message is' +e.getMessage());
            }
        }
    }
        public static void method27() {
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE createdDate = LAST_WEEK]);
        System.debug(accList);
        for(Account acc : accList) {
            acc.Phone = '1234567890';
        }
        if(!accList.isEmpty() && accList != NULL) {
            try {
                update accList;
            }
            catch(Exception e) {
                System.debug('error message is' +e.getMessage());
            }
        }
    }
    
    public static void method27a() {
        List<Account> accList = new List<Account>([SELECT Id, Name FROM Account WHERE createdDate = LAST_WEEK]);
        System.debug(accList);
        for(Account acc : accList) {
            acc.Phone = '1234567890';
        }
       System.debug(Database.update(accList, false));
    }
    public static void method28() {
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id, Name, StageName FROM Opportunity WHERE createdDate = LAST_WEEK]);
        System.debug(oppList);
        for(Opportunity opp : oppList) {
            if(opp.StageName == 'Closed Won') {
                opp.Description = 'Opportunity is closed won';
            }
            else {
                opp.Description = 'Opportunity is closed lost';
            }
        }
       System.debug(Database.update(oppList, false));
    }
    // query accounts with the related contacts and count the contacts
    public static void parentToChildQuery() {
        List<Account> accList = new List<Account>();
        accList = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Phone != NULL];
        for(Account acc : accList) {
            System.debug('the id of account is ' +acc.Id);
            System.debug('the name of account is ' +acc.Name);
            System.debug('the number of contacts are ' +acc.Contacts.size());
        }
        List<Account> accList1 = new List<Account>();
        accList1 = [SELECT Id, Name, (SELECT Id, Name, CloseDate, StageName FROM Opportunities) FROM Account WHERE Phone != NULL];
        for(Account acc : accList1) {
            System.debug('the id of account is ' +acc.Id);
            System.debug('the name of account is ' +acc.Name);
            System.debug('the number of opportunities are ' +acc.Opportunities.size());
        }
    }
    public static void method29() {
        List<Account> accList = new List<Account>([SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account ORDER BY Name ASC]);
        //select account.name, count(id) from contact group by account.name order by account.name
        for(Account acc : accList) {
            System.debug('account name is ' +acc.Name);
            System.debug('account id is ' +acc.Id);
            System.debug('Total contacts' +acc.Contacts.size());
        }
    }
    public static void method30() {
        List<Contact> conList = [SELECT Id, Name, Phone, Account.Phone FROM Contact WHERE createdDate = LAST_WEEK];
        for(Contact con : conList) {
            if(con.Phone == NULL) {
                con.Phone = con.Account.Phone;
            }
        }
        for(Contact con : conList) {
            System.debug(con.Id + ' ' + con.Account.Phone + ' ' + con.Phone);
        }
        if(conList != NULL && !conList.isEmpty()) {
            try {
                update conList;
            }
            catch(Exception e) {
                System.debug(e.getMessage());
            }
        }
    }
    public static void method31() {
        //select id, name, (select id, Name__c from Employees__r) from account where createdDate = this_year
        //SELECT Id, Name, Account__r.Id,  FROM Employee__c
        //select id, name, (select id, name from Employees__r) from account where createddate = this_year
        List<Account> accList = new List<Account>();
        accList = [SELECT Id, Name, Total_Salary__c, (SELECT Id, Name, Salary__c FROM Employees__r) FROM Account WHERE createdDate = THIS_YEAR];
        List<AggregateResult> accList1 = [SELECT sum(Salary__c), Account__r.Name FROM Employee__c WHERE Account__r.createdDate = THIS_YEAR GROUP BY Account__r.name];
        System.debug([SELECT SUM(amount), AccountId, MAX(amount), MIN(amount), AVG(amount) FROM Opportunity GROUP BY AccountId]);
    }
    public static void methodtest() {
        List<AggregateResult> aggrList = new List<AggregateResult>([SELECT Name, count(Id) FROM Account GROUP BY Name]);
        for(AggregateResult ar : aggrList) {
            System.debug(ar);
        }
    }
    public static void method31a() {
        List<AggregateResult> aggrList = [SELECT SUM(Salary__c), Account__r.id FROM Employee__c WHERE CreatedDate = THIS_YEAR GROUP BY Account__r.id];
        System.debug(aggrList);
        List<Account> listAcc = new List<Account>();
    	for(AggregateResult ar : aggrList) {
        Decimal totalSalary = (Decimal) ar.get('expr0');
        Id accId = (Id) ar.get('Id');
        Account acc = new Account();
        acc.Id = accId;
        acc.Total_Salary__c = totalSalary;
        listAcc.add(acc);
    	}
    	
    	try {
       	 	update listAcc; 
       	 	//System.debug(listAcc);
   	 	}
    	catch(Exception e) {
       	 system.debug(e.getMessage());
    	}
    }
    public static void method31b() {
        List<Account> accList = [SELECT Id, Name, (SELECT Salary__c FROM Employees__r) FROM Account WHERE createdDate = THIS_YEAR];
        List<Account> updatedAccList = new List<Account>();
        Decimal totalSalary;
        for(Account acc : accList) {
            totalSalary = 0;
            if(acc.Employees__r.size() > 0 && acc.Employees__r != NULL) {
                for(Employee__c emp : acc.Employees__r) {
                    totalSalary = totalSalary + emp.Salary__c;
                }
            }
            acc.Total_Salary__c = totalSalary;
        }
        update accList;
    }
    public static void method32() {
        List<Employee__c> empList = new List<Employee__c>([SELECT Id, Phone__c, Account__r.Id, Account__r.Phone FROM Employee__c]);
        for(Employee__c emp : empList) {
            if(emp.Phone__c == NULL) {
                emp.Phone__c = emp.Account__r.Phone;
            }
        }
        update empList;
        for(Employee__c emp : empList) {
            System.debug(emp.Phone__c);
            System.debug(emp.Account__r.Phone);
        }
    }
     public static void method33() {
        List<Contact> conList = new List<Contact>([SELECT Id, Phone, Employee__r.Id, Employee__r.Phone__c FROM Contact]);
        for(Contact con : conList) {
            if(con.Phone == NULL) {
                con.Phone = con.Employee__r.Phone__c;
            }
        }
        update conList;
        for(Contact con : conList) {
            System.debug(con.Phone);
            System.debug(con.Employee__r.Phone__c);
        }
    }

    //select id, name, Status__c, Severity__c, (select id, Status__c from Job_Applications__r) from Position__c
    //select id, First_Name__c,Last_Name__c, Phone__c, Email__c, (select id, Status__c from Job_Applications__r) from Candidate__c
    //select id, Status__c, (select id, name, Position__c, Candidate_Name__c from Reviews__r) from Job_Application__c
    	
    public static void method39() {
         List<AggregateResult> aggrRes = [
        SELECT COUNT(Id) recordCount, Job_Application__r.Id 
        FROM Review__c 
        GROUP BY Job_Application__r.Id
    ];

    for (AggregateResult ar : aggrRes) {
        System.debug('Job Application ID: ' + ar.get('Id')); // Correct key for grouped field
        System.debug('Record Count: ' + ar.get('recordCount'));                 // Key for COUNT alias
    }
    }

}