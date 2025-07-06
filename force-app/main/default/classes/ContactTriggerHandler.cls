public class ContactTriggerHandler {
    public static void sendEmailtoContact(List<Contact> conList) {
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        for(Contact con : conList) {
            if(con.Email != null) {
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                String[] toAddress = new String[]{con.Email};
                    String emailSubject = 'Welcome'+ con.FirstName;
                String disName = 'Sachin Shet';
                String content = 'Hi' + con.FirstName + '<br/><br/>' + 'Welcome to salesforce ecosystem' + '<br/><br/>' + 'Happy Learing' + '<br/><br/>' + 'Thank you' + '<br/><br/>';
                emailMsg.setToAddresses(toAddress);
                emailMsg.setSubject(emailSubject);
                emailMsg.setSenderDisplayName(disName);
                emailMsg.setHtmlBody(content);
                emailList.add(emailMsg);
            }
        }
        Messaging.sendEmail(emailList);
        System.debug('contact trigger completed');
    }
    
    
    
    
    
    
    // variable to check the recursion
    private static Boolean recursionCheck = false;
    public static void updateAccount(Map<Id, Contact> conListMap) {
        
        if(recursionCheck) {
            return;
        }
        
        recursionCheck = true;
        
        Set<Id> accIds = new Set<Id>();
        for(Contact con : conListMap.values()) {
            accIds.add(con.AccountId);
        }
        List<Account> accList = [SELECT Description FROM Account WHERE Id IN : accIds];
        for(Contact con : conListMap.values()) {
            for(Account acc : accList) {
                acc.Description = con.Description;
            }
        }
        update accList;
    }
    public static void checkDuplicationOfRecords(List<Contact> newConList, Map<Id, Contact> oldConMap) {
        Set<String> emailList = new Set<String>();
        if(newConList == null || newConList.isEmpty()) {
            return;
        }
        for(Contact con : newConList) {
            if(con.Email != null) {
                emailList.add(con.Email);
            }
            else {
                if(con.Email != null && con.Email != oldConMap.get(con.Id).Email) {
                    emailList.add(con.Email);
                }
            }
            Map<Id, Contact> conListMap = new Map<Id, Contact>();
            List<Contact> emailAlreadyExists = [SELECT Id, Email FROM Contact WHERE Email IN : emailList];
            for(String str : emailList) {
                for(Contact conn : emailAlreadyExists) {
                    if(str == conn.Email) {
                        con.addError('emal already exists brk');
                    }
                    else {
                        if(!conListMap.containsKey(conn.Id)) {
                            conn.Email = str;
                            conListMap.put(conn.Id, conn);
                        }
                    }
                }
            }
            if(!conListMap.isEmpty()) {
                update conListMap.values();
            }
        }
    }
    

    // This method is called from the trigger
    

    // This method is called from the trigger
    public static void updateTotalContacts(List<Contact> newContact, List<Contact> oldContact) {
        Set<Id> accountIds = new Set<Id>();
        if(newContact != null) {
            for(Contact con : newContact) {
                if(con.AccountId != null) {
                    accountIds.add(con.AccountId);
                }
            }
        }
        
        if(oldContact != null) {
            for(Contact con : oldContact) {
                if(con.AccountId != null) {
                    accountIds.add(con.AccountId);
                }
            }
        }
        
        Map<Id, Integer> countContactToAccountMap = new Map<Id, Integer>();
        List<AggregateResult> conList = [SELECT AccountId, Count(Id) totalContacts FROM Contact WHERE
                                        AccountId IN : accountIds GROUP BY AccountId];
        for(AggregateResult ar : conList) {
            countContactToAccountMap.put((Id)ar.get('AccountId'), (Integer)ar.get('totalContacts'));
        }
        List<Account> accListToUpdate = new List<Account>();
        for(Id accountId : accountIds) {
            Integer countContacts = countContactToAccountMap.get(accountId);
            Account acc = new Account(Id = accountId);
            acc.total_number_of_contacts_new__c = countContacts != null ? countContacts : 0;
            accListToUpdate.add(acc);
        }
        if(!accListToUpdate.isEmpty()) {
            update accListToUpdate;
        }
    }
}