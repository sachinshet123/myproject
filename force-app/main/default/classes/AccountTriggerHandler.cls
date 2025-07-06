public class AccountTriggerHandler {
    /*
  public static void updateDescription(List<Account> accList) {
    for (Account acc : accList) {
      acc.Description = 'test description through trigger by handler class';
    }
  }
  public static void updateRating(List<Account> accList) {
    for (Account acc : accList) {
      if (acc.Industry == 'Media') {
        acc.Rating = 'Hot';
      } else {
        acc.Rating = null;
      }
    }
  }
  public static void updateBillingToShippingAddress(List<Account> accList) {
    for (Account acc : accList) {
      if (
        acc.Copy_Billing_To_Shipping__c == true &&
        acc.BillingStreet != null &&
        acc.BillingPostalCode != null &&
        acc.BillingCity != null &&
        acc.BillingState != null &&
        acc.BillingCountry != null
      ) {
        acc.ShippingStreet = acc.BillingStreet;
        acc.ShippingCity = acc.BillingCity;
        acc.ShippingState = acc.BillingState;
        acc.ShippingPostalCode = acc.BillingPostalCode;
        acc.ShippingCountry = acc.BillingCountry;
      }
    }
  }
  public static void createRelatedContact(List<Account> listAcc) {
    List<Contact> conList = new List<Contact>();
    if (listAcc != null) {
      for (Account acc : listAcc) {
        Contact con = new Contact();
        con.LastName = 'shet';
        con.AccountId = acc.Id;
        conList.add(con);
      }
      insert conList;
    }
  }
  public static void createRelatedOpportunity6(List<Account> accList) {
    List<Opportunity> oppList = new List<Opportunity>();
    if (accList != null) {
      for (Account acc : accList) {
        if (acc.Active__c == 'Yes') {
          Opportunity opp = new Opportunity();
          opp.AccountId = acc.Id;
          opp.Name = acc.Name;
          opp.StageName = 'Prospecting';
          opp.CloseDate = Date.today();
          oppList.add(opp);
        }
      }
      try {
        insert oppList;
      } catch (Exception e) {
        System.debug(e.getMessage());
      }
    }
  }
  public static void createRelatedCases7(List<Account> accList) {
    List<Case> caseList = new List<Case>();
    if (accList != null) {
      for (Account acc : accList) {
        Case cs = new Case();
        cs.Origin = 'Phone';
        cs.AccountId = acc.id;
        caseList.add(cs);
      }
      insert caseList;
      Integer lastCase = caseList.size() - 1;
    }
  }
  public static void createContactAndOpportunity(List<Account> accList) {
    if (accList != null) {
      List<Contact> conList = new List<Contact>();
      List<Opportunity> oppList = new List<Opportunity>();
      for (Account acc : accList) {
        if (acc.Contact__c == true) {
          Contact con = new Contact();
          //con.Name = acc.Name;
          con.LastName = 'Contact';
          con.AccountId = acc.Id;
        }
      }
    }
  }
  public static void updateContactAndOpportunities(List<Account> accList) {
    if (accList != null) {
      List<Contact> conList = new List<Contact>();
      List<Opportunity> oppList = new List<Opportunity>();
      for (Account acc : accList) {
        if (acc.Contact__c) {
          Contact con = new Contact();
          con.LastName = 'sachin';
          con.AccountId = acc.Id;
          conList.add(con);
        }
        if (acc.Opportunity__c && acc.Active__c == 'Yes') {
          Opportunity opp = new Opportunity();
          opp.Name = 'shet';
          opp.CloseDate = Date.today();
          opp.StageName = 'Prospecting';
          opp.AccountId = acc.Id;
          oppList.add(opp);
        }
      }
      insert conList;
      insert oppList;
    }
  }
  public static void updateAccountDescriptionPhone(List<Account> accList) {
    for (Account acc : accList) {
      Account oldAcc = (Account) Trigger.oldMap.get(acc.Id);
      if (acc.Phone != oldAcc.Phone) {
        acc.Description = 'Phone number is updated';
      }
    }
    //update accList;
  }
  public static void updateAccountDescriptionPhoneNew(List<Account> accList) {
    for (Account acc : accList) {
      Account oldAcc = (Account) Trigger.oldMap.get(acc.Id);
      if (acc.Phone != oldAcc.Phone) {
        acc.Description =
          'Phone number is updated' +
          ' Old Value=' +
          oldAcc.Phone +
          ' & New Value=' +
          acc.Phone;
      }
    }
    //update accList;
  }
  public static void accountInsertedOrUpdatedThenUpdateAddress(
    List<Account> accList
  ) {
    for (Account acc : accList) {
      if (acc.Copy_Billing_To_Shipping__c) {
        acc.ShippingStreet = acc.BillingStreet;
        acc.ShippingPostalCode = acc.BillingPostalCode;
        acc.ShippingCity = acc.BillingCity;
        acc.ShippingCountry = acc.BillingCountry;
        acc.ShippingState = acc.BillingState;
      } else {
        acc.ShippingStreet = null;
        acc.ShippingPostalCode = null;
        acc.ShippingCity = null;
        acc.ShippingCountry = null;
        acc.ShippingState = null;
      }
    }
  }

  public static void updateAccountPhoneThenInAllContacts(
    Map<Id, Account> oldAccounts,
    Map<Id, Account> newAccounts
  ) {
    Set<Id> accountIdsToUpdateContacts = new Set<Id>();
    for (Id accId : newAccounts.keyset()) {
      Account oldAccount = oldAccounts.get(accId);
      Account newAccount = newAccounts.get(accId);

      if (oldAccount.Phone != newAccount.Phone) {
        accountIdsToUpdateContacts.add(accId);
      }
    }

    //Query contacts related to accounts with phone number changes
    List<Contact> contactListToUpdatePhoneNumbers = [
      SELECT Id, Phone, AccountId
      FROM Contact
      WHERE AccountId IN :accountIdsToUpdateContacts
    ];

    for (Contact con : contactListToUpdatePhoneNumbers) {
      con.Phone = newAccounts.get(con.AccountId).Phone;
    }
    update contactListToUpdatePhoneNumbers;
  }

  public static void updateAccountPhoneThenInAllContactsUsingParentChild(
    List<Account> newAccounts,
    List<Account> oldAccounts
  ) {
    Set<Id> accountIdtoUpdateContactPhone = new Set<Id>();
    for (Integer i = 0; i < newAccounts.size(); i++) {
      Account oldAccount = oldAccounts[i];
      Account newAccount = newAccounts[i];

      if (oldAccount.Phone != newAccount.Phone) {
        accountIdtoUpdateContactPhone.add(newAccount.Id);
      }
    }
    List<Account> accountsWithContacts = [
      SELECT Id, Phone, (SELECT Id, Phone FROM Contacts)
      FROM Account
      WHERE Id IN :accountIdtoUpdateContactPhone
    ];
    List<Contact> contactListToUpdate = new List<Contact>();
    for (Account acc : accountsWithContacts) {
      for (Contact con : acc.Contacts) {
        if (con.Phone != acc.Phone) {
          con.Phone = acc.Phone;
          contactListToUpdate.add(con);
        }
      }
    }
    if (!contactListToUpdate.isEmpty()) {
      update contactListToUpdate;
    }
  }

  public static void updateAccountBillingAddressToMailingAddressInRelatedContacts(
    Map<Id, Account> oldAccounts,
    Map<Id, Account> newAccounts
  ) {
    Set<Id> accountIdsToUpdateContacts = new Set<Id>();
    for (Id accId : newAccounts.keySet()) {
      Account oldAccount = oldAccounts.get(accId);
      Account newAccount = newAccounts.get(accId);

      if (
        oldAccount.BillingStreet != newAccount.BillingStreet ||
        oldAccount.BillingCity != newAccount.BillingCity ||
        oldAccount.BillingPostalCode != newAccount.BillingPostalCode ||
        oldAccount.BillingState != newAccount.BillingState ||
        oldAccount.BillingCountry != newAccount.BillingCountry
      ) {
        accountIdsToUpdateContacts.add(accId);
      }
    }

    //Query contacts related to accounts with phone number changes
    List<Contact> contactListToUpdatePhoneNumbers = [
      SELECT
        Id,
        MailingStreet,
        MailingPostalCode,
        MailingCity,
        MailingCountry,
        MailingState,
        MailingAddress,
        AccountId
      FROM Contact
      WHERE AccountId IN :accountIdsToUpdateContacts
    ];

    for (Contact con : contactListToUpdatePhoneNumbers) {
      con.MailingStreet = newAccounts.get(con.AccountId).BillingStreet;
      con.MailingPostalCode = newAccounts.get(con.AccountId).BillingPostalCode;
      con.MailingCity = newAccounts.get(con.AccountId).BillingCity;
      con.MailingCountry = newAccounts.get(con.AccountId).BillingCountry;
      con.MailingState = newAccounts.get(con.AccountId).BillingState;
    }
    update contactListToUpdatePhoneNumbers;
  }

  public static void updateAccountBillingAddressToMailingAddressInRelatedContactsUsingParentChild(
    List<Account> newAccounts,
    List<Account> oldAccounts
  ) {
    List<Id> accountIdsToUpdateMailingAddressOfContacts = new List<Id>();

    for (Integer i = 0; i < newAccounts.size(); i++) {
      Account newAccount = newAccounts[i];
      Account oldAccount = oldAccounts[i];
      if (
        newAccount.BillingCity != oldAccount.BillingCity ||
        newAccount.BillingCountry != oldAccount.BillingCountry ||
        newAccount.BillingState != oldAccount.BillingState ||
        newAccount.BillingStreet != oldAccount.BillingStreet ||
        newAccount.BillingPostalCode != newAccount.BillingPostalCode
      ) {
        accountIdsToUpdateMailingAddressOfContacts.add(newAccount.Id);
      }
    }

    List<Account> accountToUpdateAlongWithContacts = [
      SELECT
        Id,
        BillingStreet,
        BillingPostalCode,
        BillingCity,
        BillingState,
        BillingCountry,
        (
          SELECT
            Id,
            MailingStreet,
            MailingPostalCode,
            MailingCity,
            MailingState,
            MailingCountry
          FROM Contacts
        )
      FROM Account
      WHERE Id IN :accountIdsToUpdateMailingAddressOfContacts
    ];
    List<Contact> contactsToUpdate = new List<Contact>();
    for (Account acc : accountToUpdateAlongWithContacts) {
      for (Contact con : acc.Contacts) {
        con.MailingStreet = acc.BillingStreet;
        con.MailingPostalCode = acc.BillingPostalCode;
        con.MailingCity = acc.BillingCity;
        con.MailingState = acc.BillingState;
        con.MailingCountry = acc.BillingCountry;
        contactsToUpdate.add(con);
      }
    }
    if (!contactsToUpdate.isEmpty()) {
      update contactsToUpdate;
    }
  }
  public static void updateStageofAllOpportunitiesRelatedtoAccount(
    List<Account> oldAccounts,
    List<Account> newAccounts
  ) {
    List<Id> accountIdstoBeUsedtoUpdateOpportunity = new List<Id>();
    for (Integer i = 0; i < newAccounts.size(); i++) {
      Account newAccount = newAccounts[i];
      Account oldAccount = oldAccounts[i];

      if (oldAccount.Active__c == 'Yes' && newAccount.Active__c == 'No') {
        accountIdstoBeUsedtoUpdateOpportunity.add(newAccount.Id);
      }
    }
    List<Opportunity> opportunityListTobeUpdated = [
      SELECT Id, StageName, AccountId
      FROM Opportunity
      WHERE
        StageName NOT IN ('Closed Won')
        AND AccountId IN :accountIdstoBeUsedtoUpdateOpportunity
    ];
    for (Opportunity opp : opportunityListTobeUpdated) {
      opp.StageName = 'Closed Lost';
    }
    update opportunityListTobeUpdated;
  }
  public static void beforeDeleteAccounts(List<Account> oldAccounts) {
    for (Account acc : oldAccounts) {
      if (acc.Active__c == 'Yes') {
        acc.addError('Cannot be deleted');
      }
    }
  }
  public static void blockUpdatecreatedSevenDaysBefore(
    List<Account> oldAccounts,
    List<Account> newAccounts
  ) {
    for (Integer i = 0; i < newAccounts.size(); i++) {
      Account oldAccount = oldAccounts[i];
      Account newAccount = newAccounts[i];
      if (
        oldAccount.CreatedDate != null &&
        oldAccount.CreatedDate < Datetime.now().addDays(-7)
      ) {
        newAccount.addError('Cannot be edited');
      }
    }
  }
  public static void onlyForSystemAdminProfile(List<Account> accList) {
    Profile pId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
    if (UserInfo.getProfileId() != pId.Id) {
      for (Account acc : accList) {
        acc.addError('Only system administrator only able to delete');
      }
    }
  }
  public static void notAbletodeleteifhasrelatedaccoutnts(
    List<Account> oldAccList
  ) {
    Set<Id> accIds = new Set<Id>();
    for (Account acc : oldAccList) {
      accIds.add(acc.Id);
    }
    Map<Id, Account> accOppList = new Map<Id, Account>(
      [
        SELECT Id, Name, (SELECT Id FROM Opportunities)
        FROM Account
        WHERE Id IN :accIds
      ]
    );
    for (Account acc : oldAccList) {
      if (accOppList.get(acc.Id).Opportunities.size() > 0) {
        acc.addError('cannot delete account since it has opportunities');
      }
    }
  }
  public static void preventDeletionOfAccountifOpportunityStatusIsClosed(
    List<Account> oldAccList
  ) {
    Set<Id> accIds = new Set<Id>();
    for (Account acc : oldAccList) {
      accIds.add(acc.Id);
    }
    List<Opportunity> accountHasNoNonClosedLostOpportunities = [
      SELECT AccountId, StageName
      FROM Opportunity
      WHERE AccountId IN :accIds AND StageName != 'Closed Lost'
    ];
    Map<Id, Boolean> accIdMap = new Map<Id, Boolean>();
    for (Opportunity opp : accountHasNoNonClosedLostOpportunities) {
      accIdMap.put(opp.AccountId, true);
    }
    for (Account acc : oldAccList) {
      if (accIdMap.containsKey(acc.id)) {
        acc.addError('accounts cannot be deleted');
      }
    }
  }
  public static void preventDeletionOfCases(List<Account> oldAccList) {
    Set<Id> accIds = new Set<Id>();
    for (Account acc : oldAccList) {
      accIds.add(acc.Id);
    }
    List<Case> caseList = [
      SELECT AccountId
      FROM Case
      WHERE AccountId IN :accIds
    ];
    for (Account acc : oldAccList) {
      if (acc.Cases.size() > 0) {
        acc.addError('cannot delete account because cases are more than 0');
      }
    }
  }
  public static void undeleteDeletedRecords(
    List<Account> oldAccounts,
    List<Account> newAccounts
  ) {
    // Step 1: Collect Account IDs from newAccounts where Active__c is updated to 'Yes'
    Set<Id> activeAccountIds = new Set<Id>();
    for (Account newAcc : newAccounts) {
      // Account oldAcc = oldAccounts != null && oldAccounts.contains(newAcc.Id) ? oldAccounts.get(newAcc.Id) : null;

      // Check if Active__c is updated to 'Yes'
      //if (oldAcc != null && newAcc.Active__c == 'Yes' && oldAcc.Active__c != 'Yes') {
      activeAccountIds.add(newAcc.Id);
      // }
    }

    // Step 2: Query deleted Employee records related to these accounts
    if (!activeAccountIds.isEmpty()) {
      List<Employee__c> deletedEmployees = [
        SELECT Id, Name, Account__c, LastModifiedDate
        FROM Employee__c
        WHERE IsDeleted = TRUE AND Account__c IN :activeAccountIds
        ORDER BY LastModifiedDate DESC
        LIMIT 10
        ALL ROWS
      ];

      // Step 3: Undelete the queried Employee records
      if (!deletedEmployees.isEmpty()) {
        undelete deletedEmployees;
      }
    }
  }
  public static void preventDeletionOfChildObjects(
    Map<Id, Account> oldAccList
  ) {
    List<Opportunity> oppList = [
      SELECT Id, AccountId
      FROM Opportunity
      WHERE AccountId IN :oldAccList.keySet()
    ];
    if (!oppList.isEmpty()) {
      for (Account acc : oldAccList.values()) {
        acc.addError('Cannot be deleted');
      }
    }
  }
  public static void insertOpportunities(List<Account> accList) {
    List<Opportunity> oppList = new List<Opportunity>();
    for (Account acc : accList) {
      Opportunity opp = new Opportunity();
      opp.Name = acc.Name;
      opp.Amount = 500;
      opp.CloseDate = Date.today();
      opp.StageName = 'Prospecting';
      opp.AccountId = acc.id;
      oppList.add(opp);
    }
    Database.SaveResult[] srList = Database.insert(oppList, false); // this is array
    for (Integer i = 0; i < srList.size(); i++) {
      if (!srList[i].isSuccess()) {
        String error = '';
        for (Database.Error err : srList[i].getErrors()) {
          error = error + err.getMessage();
        }
        accList[i].addError(error);
      }
    }
  }

  private static Boolean recursionCheck = false;
  public static void updateContacts(Map<Id, Account> accListMap) {
    if (recursionCheck) {
      return;
    }

    recursionCheck = true;
    List<Contact> conList = [
      SELECT Description, AccountId
      FROM Contact
      WHERE AccountId IN :accListMap.keySet()
    ];
    for (Contact con : conList) {
      con.Description = accListMap.get(con.AccountId).Description;
    }
    update conList;
  }
  public static void updateOpportunityStatusToClosedLost(
    List<Account> newAccList,
    Map<Id, Account> oldAccMap
  ) {
    Set<Id> accIds = new Set<Id>();
    for (Account acc : newAccList) {
      if (
        acc.Active__c != oldAccMap.get(acc.Id).Active__c &&
        acc.Active__c == 'No'
      ) {
        accIds.add(acc.Id);
      }
    }
    List<Opportunity> oppList = [
      SELECT StageName, AccountId
      FROM Opportunity
      WHERE AccountId IN :accIds
    ];
    for (Opportunity opp : oppList) {
      opp.StageName = 'Closed Lost';
    }
    update oppList;
  } //
  public static void updateOwnerFieldOnContacts(
    List<Account> newAccList,
    Map<Id, Account> oldAccMap
  ) {
    Set<Id> accIds = new Set<Id>();
    for (Account acc : newAccList) {
      if (acc.Id != null && acc.OwnerId != oldAccMap.get(acc.Id).OwnerId) {
        accIds.add(acc.Id);
      }
    }
    List<Account> accList = [
      SELECT Id, OwnerId, (SELECT Id, OwnerId FROM Contacts)
      FROM Account
      WHERE Id IN :accIds
    ];
    for (Account acc : accList) {
      for (Contact con : acc.Contacts) {
        con.OwnerId = acc.OwnerId;
      }
    }
    update accList;
  }
  public static void blockDuplicateRecords(List<Account> accNewList) {
    Set<String> nameSet = new Set<String>();
    Set<String> industrySet = new Set<String>();
    for (Account acc : accNewList) {
      nameSet.add(acc.Name);
      industrySet.add(acc.Industry);
    }
    List<Account> accList = [
      SELECT Id, Name, Industry
      FROM Account
      WHERE Name IN :nameSet AND Industry IN :industrySet
    ];
    for (Account accNew : accNewList) {
      for (Account acc : accList) {
        if (accNew.Name == acc.Name && accNew.Industry == acc.Industry) {
          accNew.addError('duplicate record');
          break;
        }
      }
    }
  }
    public static void updateContactsCustomCheckbox() {
        
    }
*/
    
    public static void updateAccount(List<Account> accList) {
        for(Account acc : accList) {
            if(acc.Industry!= null && acc.Industry == 'Media') {
                acc.Rating = 'Hot';
            }
        }
    }
    public static void updateBillingAddressToShippingAddress(List<Account> accList) {
        for(Account acc : accList) {
            if(acc.Copy_Billing_To_Shipping__c == true) {
                acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingPostalCode = acc.BillingPostalCode;
                acc.ShippingState = acc.BillingState;
                acc.ShippingCountry = acc.BillingCountry;
            }
        }
    }
    public static void createRelatedContacts(List<Account> accList) {
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList) {
            for(Integer i=0; i<4; i++) {
            Contact con = new Contact(LastName='shet' +i, AccountId = acc.Id);
            conList.add(con);
        }
      }
        if(!conList.isEmpty()) {
            insert conList;
        }
    }
    
    public static void createRelatedOpportunities(List<Account> accList) {
    List<Opportunity> oppList = new List<Opportunity>();

    for (Account acc : accList) {
        if (acc.Active__c == 'Yes') {
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name + ' Opportunity'; // optional suffix to distinguish
            opp.CloseDate = Date.today();
            opp.StageName = 'Prospecting';
            opp.AccountId = acc.Id;
            oppList.add(opp); // 🔴 You missed this
        }
    }

    if (!oppList.isEmpty()) {
        insert oppList;
    }
}
    
    public static void createRelatedContactsAndOpportunities(List<Account> accList) {
        System.debug('trigger2');
        List<Contact> conList = new List<Contact>();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc : accList) {
            if(acc.Create_Contact__c == true) {
                System.debug('6');
                Contact con = new Contact(AccountId=acc.Id, LastName = 'test contact');
                conList.add(con);
            }
            if(acc.Create_Opportunity__c == true && acc.Active__c == 'Yes') {
                System.debug('7');
                Opportunity opp = new Opportunity(AccountId = acc.Id, Amount = 20000, CloseDate = Date.today(), StageName = 'Prospecting', Name = 'test opp');
                oppList.add(opp);
            }
        }
        insert conList;
        insert oppList;
        System.debug('trigger3');
    }
    
    
    
    public static void updateDescription(List<Account> newAccList, Map<Id, Account> oldAccMap) {
            if(newAccList != null) {
            for(Account acc : newAccList) {
            if(acc.Phone != oldAccMap.get(acc.Id).Phone) {
                acc.Description = 'old value ' + oldAccMap.get(acc.Id).Phone + 'new value' + acc.Phone;
            	}
        	}
        }
    }
    
    public static void copyBillingToShipping(List<Account> newAccList, Map<Id, Account> oldAccMap) {
        for(Account acc : newAccList) {
            if(acc.Copy_Billing_To_Shipping_New__c == true) {
                acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingPostalCode = acc.BillingPostalCode;
                acc.ShippingState = acc.BillingState;
                acc.ShippingCountry = acc.BillingCountry;
            }
            if(oldAccMap.get(acc.Id).Copy_Billing_To_Shipping_New__c != acc.Copy_Billing_To_Shipping_New__c && 
               acc.Copy_Billing_To_Shipping_New__c == true) {
                   acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingPostalCode = acc.BillingPostalCode;
                acc.ShippingState = acc.BillingState;
                acc.ShippingCountry = acc.BillingCountry;
               }
        }
    }
    
    public static void updateRating(List<Account> newAccList, Map<Id, Account> oldAccList) {
    if (newAccList != null) {
        for (Account acc : newAccList) {
            // Check if this is an update (i.e., old value is available)
            Account oldAcc = (oldAccList != null) ? oldAccList.get(acc.Id) : null;

            // Now safely handle conditions
            if (acc.Industry == 'Media' && 
                (oldAcc != null && acc.Industry != oldAcc.Industry)) {
                acc.Rating = 'Hot';
            }
            if (acc.Industry != 'Media' && 
                (oldAcc != null && acc.Industry != oldAcc.Industry)) {
                    acc.Rating = '';
                }
        }
    }
    }
    
    
    public static void updateRelatedContactPhoneFieldUsingMap(List<Account> newAccList, Map<Id, Account> oldAccMap) {
        Map<Id, Account> accountMap = new Map<Id, Account>();
        if(newAccList != null) {
            for(Account acc : newAccList) {
                if(acc.Phone != oldAccMap.get(acc.Id).Phone) {
                    accountMap.put(acc.Id, acc);
                }
            }
        }
        List<Contact> updateContacts = [SELECT Id, HomePhone, AccountId FROM Contact WHERE AccountId IN : accountMap.keySet()];
        for(Contact con : updateContacts) {
            if(accountMap.containsKey(con.AccountId)) {
                con.HomePhone = accountMap.get(con.AccountId).Phone;
            }
        }
        update updateContacts;
    }
    
    public static void updateRelatedContactPhoneFieldUsingChildToParent(List<Account> newAccList, Map<Id, Account> oldAccMap) {
        Set<Id> accIds = new Set<Id>();
        if(newAccList != null) {
            for(Account acc : newAccList) {
                if(oldAccMap.containsKey(acc.Id) && acc.Phone != oldAccMap.get(acc.Id).Phone) {
                    accIds.add(acc.Id);
                }
            }
        }
        if(accIds.isEmpty()) {
            return;
        }
        
        List<Account> accWithContacts = [SELECT Id, Phone, (SELECT Id, HomePhone, AccountId FROM Contacts) FROM Account 
                                        WHERE Id IN : accIds];
        
        List<Contact> contactsToUpdate =new  List<Contact>();
        for(Account acc : accWithContacts) {
            for(Contact con : acc.Contacts) {
                con.HomePhone = acc.Phone;
                contactsToUpdate.add(con);
            }
        }
        if(!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
        }
    
    public static void updateRelatedBillingToMailingAddressUsingChildToParent(List<Account> newAccList, Map<Id, Account> oldAccMap) {
        Set<Id> accIds = new Set<Id>();
        if(newAccList != null) {
            for(Account acc : newAccList) {
                if(acc.BillingStreet != oldAccMap.get(acc.Id).BillingStreet ||
                  acc.BillingCity != oldAccMap.get(acc.Id).BillingCity ||
                  acc.BillingPostalCode != oldAccMap.get(acc.Id).BillingPostalCode ||
                  acc.BillingState != oldAccMap.get(acc.Id).BillingState ||
                  acc.BillingCountry != oldAccMap.get(acc.Id).BillingCountry) {
                    accIds.add(acc.Id);
                }
            }
        }
        if(accIds.isEmpty()) {
            return;
        }
        
        List<Account> accWithContacts = [SELECT Id, BillingStreet, BillingCity, BillingPostalCode, 
                                         BillingState, BillingCountry, 
                                         (SELECT Id, MailingStreet, MailingCity, MailingPostalCode, MailingState, MailingCountry, AccountId FROM Contacts) FROM Account 
                                        WHERE Id IN : accIds];
        
        List<Contact> contactsToUpdate =new  List<Contact>();
        for(Account acc : accWithContacts) {
            for(Contact con : acc.Contacts) {
                con.MailingStreet = acc.BillingStreet;
                con.MailingCity = acc.BillingCity;
                con.MailingPostalCode = acc.BillingPostalCode;
                con.MailingState = acc.BillingState;
                con.MailingCountry = acc.BillingCountry;
                contactsToUpdate.add(con);
            }
        }
        if(!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
        }
    
    
    public static void updateRelatedBillingAddressToMailingAddressdUsingMap(List<Account> newAccList, Map<Id, Account> oldAccMap) {
        Map<Id, Account> accountMap = new Map<Id, Account>();
        if(newAccList != null) {
            for(Account acc : newAccList) {
                if(acc.BillingStreet != oldAccMap.get(acc.Id).BillingStreet ||
                  acc.BillingCity != oldAccMap.get(acc.Id).BillingCity ||
                  acc.BillingPostalCode != oldAccMap.get(acc.Id).BillingPostalCode ||
                  acc.BillingState != oldAccMap.get(acc.Id).BillingState ||
                  acc.BillingCountry != oldAccMap.get(acc.Id).BillingCountry) {
                    accountMap.put(acc.Id, acc);
                }
            }
        }
        List<Contact> updateContacts = [SELECT Id, MailingStreet, MailingCity, 
                                        MailingPostalCode, MailingState, MailingCountry, 
                                        AccountId FROM Contact WHERE AccountId IN : accountMap.keySet()];
        for(Contact con : updateContacts) {
            if(accountMap.containsKey(con.AccountId)) {
                con.MailingStreet = accountMap.get(con.AccountId).BillingStreet;
                con.MailingCity = accountMap.get(con.AccountId).BillingCity;
                con.MailingPostalCode = accountMap.get(con.AccountId).BillingPostalCode;
                con.MailingState = accountMap.get(con.AccountId).BillingState;
                con.MailingCountry = accountMap.get(con.AccountId).BillingCountry;
            }
        }
        update updateContacts;
    }
    
    public static void updateOpportunityStatus(List<Account> newAccList, Map<Id, Account> oldAccMap) {
        Map<Id, Account> accMap = new Map<Id, Account>();
        if(newAccList != null) {
            for(Account acc : newAccList) {
                if(acc.Active__c != oldAccMap.get(acc.Id).Active__c && acc.Active__c == 'No') {
                    accMap.put(acc.Id, acc);
                }
            }
        }
        List<Opportunity> oppUpdate = new List<Opportunity>();
        List<Opportunity> oppListToBeUpdated = [SELECT Id, StageName, AccountId FROM Opportunity WHERE AccountId IN : accMap.keySet()];
        for(Opportunity opp : oppListToBeUpdated) {
            if(accMap.containsKey(opp.AccountId) && opp.StageName != 'Closed Won') {
                opp.StageName = 'Closed Lost';
                oppUpdate.add(opp);
            }
        }
        if(!oppListToBeUpdated.isEmpty()) {
            update oppUpdate;
        }
    }
   
    public static void cannotdeleteifaccountactive(List<Account> oldAccList) {
            for(Account acc : oldAccList) {
                if(acc.Active__c == 'Yes') {
                    acc.addError('cannot be deleted');
                }
            }
        }
    
    public static void preventRecordUpdateCreatedSevenDaysBack(List<Account> newAccList) {
        Set<Id> accIds = new Set<Id>();
        if(newAccList != null) {
            for(Account acc : newAccList) {
                accIds.add(acc.Id);
            }
        }
    List<Account> accList = [SELECT Id, CreatedDate FROM Account WHERE Id IN :accIds];
    for (Account acc : accList) {
        if (Date.today().daysBetween(acc.CreatedDate.date()) < 7) {
            // Add error to the record in Trigger context
            acc.addError('Records created within the last 7 days cannot be edited.');
        }
    }
}

}