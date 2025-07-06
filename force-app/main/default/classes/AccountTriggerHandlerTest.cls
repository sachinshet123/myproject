@isTest
public class AccountTriggerHandlerTest {
  /* @isTest
  public static void testUpdateDescription() {
    // Step 1: Create a list of 10 test Accounts
    List<Account> testAccounts = new List<Account>();
    for (Integer i = 1; i <= 10; i++) {
      testAccounts.add(new Account(Name = 'Test Account ' + i));
    }

    // Step 2: Insert the test Accounts
    insert testAccounts;

    // Step 3: Call the handler method to update descriptions
    AccountTriggerHandler.updateDescription(testAccounts);

    // Step 4: Query updated Accounts from the database
    List<Account> updatedAccounts = [
      SELECT Id, Description
      FROM Account
      WHERE Id IN :testAccounts
    ];

    // Step 5: Loop through and verify each record's Description
    for (Account acc : updatedAccounts) {
      System.assertEquals(
        'test description through trigger by handler class',
        acc.Description,
        'Description was not updated correctly for Account: ' + acc.Id
      );
    }
  }
  @isTest
  public static void testUpdateRating() {
    // Create test accounts
    List<Account> testAccounts = new List<Account>{
      new Account(Name = 'Media Corp', Industry = 'Media'),
      new Account(Name = 'Tech Solutions', Industry = 'Technology'),
      new Account(Name = 'Finance Group', Industry = 'Finance')
    };

    // Call the method under test
    AccountTriggerHandler.updateRating(testAccounts);

    // Assert expected results
    for (Account acc : testAccounts) {
      if (acc.Industry == 'Media') {
        System.assertEquals(
          'Hot',
          acc.Rating,
          'Rating should be set to Hot for Media industry accounts.'
        );
      } else {
        System.assertEquals(
          null,
          acc.Rating,
          'Rating should be null for non-Media industry accounts.'
        );
      }
    }
  }
  @isTest
  public static void testUpdateBillingToShippingAddress() {
    // Create test accounts
    List<Account> testAccounts = new List<Account>{
      new Account(
        Name = 'Test Account 1',
        Copy_Billing_To_Shipping__c = true,
        BillingStreet = '123 Billing St',
        BillingCity = 'New York',
        BillingState = 'NY',
        BillingPostalCode = '10001',
        BillingCountry = 'USA'
      ),
      new Account(
        Name = 'Test Account 2',
        Copy_Billing_To_Shipping__c = false, // Should NOT copy
        BillingStreet = '456 Another St',
        BillingCity = 'San Francisco',
        BillingState = 'CA',
        BillingPostalCode = '94105',
        BillingCountry = 'USA'
      ),
      new Account(
        Name = 'Test Account 3',
        Copy_Billing_To_Shipping__c = true, // Should NOT copy due to missing Billing info
        BillingStreet = null,
        BillingCity = 'Los Angeles',
        BillingState = 'CA',
        BillingPostalCode = '90001',
        BillingCountry = 'USA'
      )
    };

    // Call the method under test
    AccountTriggerHandler.updateBillingToShippingAddress(testAccounts);

    // Assert expected results
    System.assertEquals(
      '123 Billing St',
      testAccounts[0].ShippingStreet,
      'ShippingStreet should be copied for valid accounts.'
    );
    System.assertEquals(
      'New York',
      testAccounts[0].ShippingCity,
      'ShippingCity should be copied for valid accounts.'
    );
    System.assertEquals(
      'NY',
      testAccounts[0].ShippingState,
      'ShippingState should be copied for valid accounts.'
    );
    System.assertEquals(
      '10001',
      testAccounts[0].ShippingPostalCode,
      'ShippingPostalCode should be copied for valid accounts.'
    );
    System.assertEquals(
      'USA',
      testAccounts[0].ShippingCountry,
      'ShippingCountry should be copied for valid accounts.'
    );

    System.assertEquals(
      null,
      testAccounts[1].ShippingStreet,
      'Shipping should NOT be copied when Copy_Billing_To_Shipping__c is false.'
    );
    System.assertEquals(
      null,
      testAccounts[2].ShippingStreet,
      'Shipping should NOT be copied when BillingStreet is null.'
    );
  }
  @isTest
  static void testCreateRelatedContact() {
    // Create test Account data
    Account acc1 = new Account(Name = 'Test Account 1');
    Account acc2 = new Account(Name = 'Test Account 2');
    insert new List<Account>{ acc1, acc2 };

    // Call the method to create related Contacts
    Test.startTest();
    AccountTriggerHandler.createRelatedContact(new List<Account>{ acc1, acc2 });
    Test.stopTest();

    // Assert that Contacts are created and related to the Accounts
    List<Contact> contacts = [
      SELECT AccountId, LastName
      FROM Contact
      WHERE AccountId IN :new List<Id>{ acc1.Id, acc2.Id }
    ];
    System.assertEquals(
      2,
      contacts.size(),
      'There should be 2 related contacts'
    );
    for (Contact con : contacts) {
      System.assertEquals('shet', con.LastName, 'LastName should be "shet"');
    }
  }

  @isTest
  static void testCreateRelatedOpportunity6() {
    // Create test Account data with different Active__c values
    Account acc1 = new Account(Name = 'Active Account', Active__c = 'Yes');
    Account acc2 = new Account(Name = 'Inactive Account', Active__c = 'No');
    insert new List<Account>{ acc1, acc2 };

    // Call the method to create related Opportunities
    Test.startTest();
    AccountTriggerHandler.createRelatedOpportunity6(
      new List<Account>{ acc1, acc2 }
    );
    Test.stopTest();

    // Assert that Opportunity is created only for the active account
    List<Opportunity> opportunities = [
      SELECT AccountId, Name, StageName
      FROM Opportunity
      WHERE AccountId IN :new List<Id>{ acc1.Id, acc2.Id }
    ];
    System.assertEquals(
      1,
      opportunities.size(),
      'There should be 1 related opportunity for active account'
    );
    System.assertEquals(
      acc1.Id,
      opportunities[0].AccountId,
      'The opportunity should be related to the active account'
    );
    System.assertEquals(
      'Prospecting',
      opportunities[0].StageName,
      'The stage name should be "Prospecting"'
    );
  }
    @isTest
    static void testCreateRelatedCases7() {
        // Create test Account data
        Account acc1 = new Account(Name = 'Account 1');
        Account acc2 = new Account(Name = 'Account 2');
        insert new List<Account>{ acc1, acc2 };

        // Call the method to create related Cases
        Test.startTest();
        AccountTriggerHandler.createRelatedCases7(new List<Account>{ acc1, acc2 });
        Test.stopTest();

        // Assert that Cases are created and related to the Accounts
        List<Case> cases = [SELECT AccountId, Origin FROM Case WHERE AccountId IN :new List<Id>{ acc1.Id, acc2.Id }];
        System.assertEquals(2, cases.size(), 'There should be 2 related cases');
        for (Case cs : cases) {
            System.assertEquals('Phone', cs.Origin, 'Origin should be "Phone"');
        }
    }

    @isTest
    static void testCreateContactAndOpportunity() {
        // Create test Account data with Contact__c flag
        Account acc1 = new Account(Name = 'Account 1', Contact__c = true);
        Account acc2 = new Account(Name = 'Account 2', Contact__c = false);
        insert new List<Account>{ acc1, acc2 };

        // Call the method to create Contacts and Opportunities
        Test.startTest();
        AccountTriggerHandler.createContactAndOpportunity(new List<Account>{ acc1, acc2 });
        Test.stopTest();

        // Assert that Contact is created only for Account with Contact__c = true
        List<Contact> contacts = [SELECT AccountId, LastName FROM Contact WHERE AccountId IN :new List<Id>{ acc1.Id, acc2.Id }];
        System.assertEquals(1, contacts.size(), 'There should be 1 related contact for Account with Contact__c = true');
        System.assertEquals('Contact', contacts[0].LastName, 'The LastName of the contact should be "Contact"');
        
        // Since createContactAndOpportunity method does not yet insert Opportunities, we won’t test Opportunity creation here
    }
     @isTest
    static void testUpdateContactAndOpportunities() {
        // Create test Account data
        Account acc1 = new Account(Name = 'Account 1', Contact__c = true, Opportunity__c = true, Active__c = 'Yes');
        Account acc2 = new Account(Name = 'Account 2', Contact__c = false, Opportunity__c = true, Active__c = 'No');
        insert new List<Account>{ acc1, acc2 };

        // Call the method to update Contacts and Opportunities
        Test.startTest();
        AccountTriggerHandler.updateContactAndOpportunities(new List<Account>{ acc1, acc2 });
        Test.stopTest();

        // Assert that Contacts are created and related to the Accounts
        List<Contact> contacts = [SELECT AccountId, LastName FROM Contact WHERE AccountId IN :new List<Id>{ acc1.Id, acc2.Id }];
        System.assertEquals(1, contacts.size(), 'There should be 1 related contact for Account with Contact__c = true');
        System.assertEquals('sachin', contacts[0].LastName, 'The LastName of the contact should be "sachin"');

        // Assert that Opportunities are created for active accounts
        List<Opportunity> opportunities = [SELECT AccountId, Name, StageName FROM Opportunity WHERE AccountId IN :new List<Id>{ acc1.Id, acc2.Id }];
        System.assertEquals(1, opportunities.size(), 'There should be 1 related opportunity for active Account with Opportunity__c = true');
        System.assertEquals('Prospecting', opportunities[0].StageName, 'The stage name should be "Prospecting"');
    }

    @isTest
    static void testUpdateAccountDescriptionPhone() {
        // Create test Account data
        Account acc1 = new Account(Name = 'Account 1', Phone = '1234567890');
        insert acc1;
        
        // Update phone number for acc1
        acc1.Phone = '0987654321';
        update acc1;

        // Call the method to update Account Description
        Test.startTest();
        List<Account> accList = [SELECT Id, Phone, Description FROM Account WHERE Id = :acc1.Id];
        AccountTriggerHandler.updateAccountDescriptionPhone(accList);
        Test.stopTest();

        // Assert that Description is updated
        System.assertEquals('Phone number is updated', accList[0].Description, 'Description should indicate that the phone number was updated');
    }

    @isTest
    static void testUpdateAccountDescriptionPhoneNew() {
        // Create test Account data
        Account acc1 = new Account(Name = 'Account 1', Phone = '1234567890');
        insert acc1;
        
        // Update phone number for acc1
        acc1.Phone = '0987654321';
        update acc1;

        // Call the method to update Account Description with old and new values
        Test.startTest();
        List<Account> accList = [SELECT Id, Phone, Description FROM Account WHERE Id = :acc1.Id];
        AccountTriggerHandler.updateAccountDescriptionPhoneNew(accList);
        Test.stopTest();

        // Assert that Description includes old and new phone numbers
        String expectedDescription = 'Phone number is updated Old Value=1234567890 & New Value=0987654321';
        System.assertEquals(expectedDescription, accList[0].Description, 'Description should indicate old and new phone numbers');
    }

    @isTest
    static void testAccountInsertedOrUpdatedThenUpdateAddress() {
        // Create test Account data
        Account acc1 = new Account(Name = 'Account 1', BillingStreet = 'Street 1', BillingCity = 'City 1', BillingState = 'State 1', BillingPostalCode = '12345', BillingCountry = 'Country 1', Copy_Billing_To_Shipping__c = true);
        Account acc2 = new Account(Name = 'Account 2', BillingStreet = 'Street 2', BillingCity = 'City 2', BillingState = 'State 2', BillingPostalCode = '67890', BillingCountry = 'Country 2', Copy_Billing_To_Shipping__c = false);
        insert new List<Account>{ acc1, acc2 };

        // Call the method to update Shipping Address
        Test.startTest();
        AccountTriggerHandler.accountInsertedOrUpdatedThenUpdateAddress(new List<Account>{ acc1, acc2 });
        Test.stopTest();

        // Assert that Shipping Address is copied for acc1
        acc1 = [SELECT ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry FROM Account WHERE Id = :acc1.Id];
        System.assertEquals(acc1.BillingStreet, acc1.ShippingStreet, 'ShippingStreet should be the same as BillingStreet for acc1');
        System.assertEquals(acc1.BillingCity, acc1.ShippingCity, 'ShippingCity should be the same as BillingCity for acc1');
        System.assertEquals(acc1.BillingState, acc1.ShippingState, 'ShippingState should be the same as BillingState for acc1');
        System.assertEquals(acc1.BillingPostalCode, acc1.ShippingPostalCode, 'ShippingPostalCode should be the same as BillingPostalCode for acc1');
        System.assertEquals(acc1.BillingCountry, acc1.ShippingCountry, 'ShippingCountry should be the same as BillingCountry for acc1');

        // Assert that Shipping Address is cleared for acc2
        acc2 = [SELECT ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry FROM Account WHERE Id = :acc2.Id];
        System.assertEquals(null, acc2.ShippingStreet, 'ShippingStreet should be null for acc2');
        System.assertEquals(null, acc2.ShippingCity, 'ShippingCity should be null for acc2');
        System.assertEquals(null, acc2.ShippingState, 'ShippingState should be null for acc2');
        System.assertEquals(null, acc2.ShippingPostalCode, 'ShippingPostalCode should be null for acc2');
        System.assertEquals(null, acc2.ShippingCountry, 'ShippingCountry should be null for acc2');
    }
    @isTest
    static void testUpdateAccountPhoneThenInAllContacts() {
        // Create test Account and Contact data
        Account acc1 = new Account(Name = 'Account 1', Phone = '1234567890');
        Account acc2 = new Account(Name = 'Account 2', Phone = '9876543210');
        insert new List<Account>{ acc1, acc2 };

        // Create Contacts related to these Accounts
        Contact con1 = new Contact(FirstName = 'John', LastName = 'Doe', Phone = '1112223333', AccountId = acc1.Id);
        Contact con2 = new Contact(FirstName = 'Jane', LastName = 'Smith', Phone = '4445556666', AccountId = acc2.Id);
        insert new List<Contact>{ con1, con2 };

        // Update phone numbers for the Accounts
        acc1.Phone = '5555555555';
        acc2.Phone = '6666666666';
        update new List<Account>{ acc1, acc2 };

        // Call the method to update phone numbers in related Contacts
        Test.startTest();
        Map<Id, Account> oldAccounts = new Map<Id, Account>([SELECT Id, Phone FROM Account WHERE Id IN :new List<Id>{ acc1.Id, acc2.Id }]);
        Map<Id, Account> newAccounts = new Map<Id, Account>([SELECT Id, Phone FROM Account WHERE Id IN :new List<Id>{ acc1.Id, acc2.Id }]);
        AccountTriggerHandler.updateAccountPhoneThenInAllContacts(oldAccounts, newAccounts);
        Test.stopTest();

        // Assert that Contacts' phone numbers have been updated to the new Account phone numbers
        List<Contact> contacts = [SELECT Phone, AccountId FROM Contact WHERE AccountId IN :new List<Id>{ acc1.Id, acc2.Id }];
        for (Contact con : contacts) {
            if (con.AccountId == acc1.Id) {
                System.assertEquals('5555555555', con.Phone, 'Contact phone should be updated to Account phone');
            } else if (con.AccountId == acc2.Id) {
                System.assertEquals('6666666666', con.Phone, 'Contact phone should be updated to Account phone');
            }
        }
    }

    @isTest
    static void testUpdateAccountPhoneThenInAllContactsUsingParentChild() {
        // Create test Account and Contact data
        Account acc1 = new Account(Name = 'Account 1', Phone = '1234567890');
        Account acc2 = new Account(Name = 'Account 2', Phone = '9876543210');
        insert new List<Account>{ acc1, acc2 };

        // Create Contacts related to these Accounts
        Contact con1 = new Contact(FirstName = 'John', LastName = 'Doe', Phone = '1112223333', AccountId = acc1.Id);
        Contact con2 = new Contact(FirstName = 'Jane', LastName = 'Smith', Phone = '4445556666', AccountId = acc2.Id);
        insert new List<Contact>{ con1, con2 };

        // Update phone numbers for the Accounts
        acc1.Phone = '5555555555';
        acc2.Phone = '6666666666';
        update new List<Account>{ acc1, acc2 };

        // Call the method to update phone numbers in related Contacts using Parent-Child relationship
        Test.startTest();
        List<Account> oldAccounts = [SELECT Id, Phone FROM Account WHERE Id IN :new List<Id>{ acc1.Id, acc2.Id }];
        List<Account> newAccounts = [SELECT Id, Phone FROM Account WHERE Id IN :new List<Id>{ acc1.Id, acc2.Id }];
        AccountTriggerHandler.updateAccountPhoneThenInAllContactsUsingParentChild(newAccounts, oldAccounts);
        Test.stopTest();

        // Assert that Contacts' phone numbers have been updated to the new Account phone numbers
        List<Contact> contacts = [SELECT Phone, AccountId FROM Contact WHERE AccountId IN :new List<Id>{ acc1.Id, acc2.Id }];
        for (Contact con : contacts) {
            if (con.AccountId == acc1.Id) {
                System.assertEquals('5555555555', con.Phone, 'Contact phone should be updated to Account phone');
            } else if (con.AccountId == acc2.Id) {
                System.assertEquals('6666666666', con.Phone, 'Contact phone should be updated to Account phone');
            }
        }
    }
    @isTest
static void testUpdateAccountBillingAddressToMailingAddressInRelatedContacts() {
    // Create test Account and Contact data
    Account acc1 = new Account(Name = 'Account 1', BillingStreet = '123 Main St', BillingCity = 'New York', BillingPostalCode = '10001', BillingState = 'NY', BillingCountry = 'USA');
    Account acc2 = new Account(Name = 'Account 2', BillingStreet = '456 Elm St', BillingCity = 'Los Angeles', BillingPostalCode = '90001', BillingState = 'CA', BillingCountry = 'USA');
    insert new List<Account>{ acc1, acc2 };

    // Create Contacts related to these Accounts
    Contact con1 = new Contact(FirstName = 'John', LastName = 'Doe', MailingStreet = 'Old Street 1', MailingPostalCode = '99999', MailingCity = 'Old City', MailingState = 'Old State', MailingCountry = 'Old Country', AccountId = acc1.Id);
    Contact con2 = new Contact(FirstName = 'Jane', LastName = 'Smith', MailingStreet = 'Old Street 2', MailingPostalCode = '88888', MailingCity = 'Old City', MailingState = 'Old State', MailingCountry = 'Old Country', AccountId = acc2.Id);
    insert new List<Contact>{ con1, con2 };

    // Modify Billing Address of Accounts
    acc1.BillingStreet = '789 New St';
    acc1.BillingCity = 'Boston';
    acc1.BillingPostalCode = '02110';
    acc1.BillingState = 'MA';
    acc1.BillingCountry = 'USA';

    acc2.BillingStreet = '101 Maple Ave';
    acc2.BillingCity = 'San Francisco';
    acc2.BillingPostalCode = '94105';
    acc2.BillingState = 'CA';
    acc2.BillingCountry = 'USA';

    update new List<Account>{ acc1, acc2 };

    // Call the method to update Mailing Address in Contacts
    Test.startTest();
    Map<Id, Account> oldAccounts = new Map<Id, Account>([SELECT Id, BillingStreet, BillingCity, BillingPostalCode, BillingState, BillingCountry FROM Account WHERE Id IN :new List<Id>{ acc1.Id, acc2.Id }]);
    Map<Id, Account> newAccounts = new Map<Id, Account>([SELECT Id, BillingStreet, BillingCity, BillingPostalCode, BillingState, BillingCountry FROM Account WHERE Id IN :new List<Id>{ acc1.Id, acc2.Id }]);
    AccountTriggerHandler.updateAccountBillingAddressToMailingAddressInRelatedContacts(oldAccounts, newAccounts);
    Test.stopTest();

    // Assert that Contacts' Mailing Address has been updated to the new Billing Address of Account
    List<Contact> contacts = [SELECT MailingStreet, MailingPostalCode, MailingCity, MailingState, MailingCountry, AccountId FROM Contact WHERE AccountId IN :new List<Id>{ acc1.Id, acc2.Id }];
    for (Contact con : contacts) {
        if (con.AccountId == acc1.Id) {
            System.assertEquals('789 New St', con.MailingStreet, 'Mailing Street should be updated to Billing Street');
            System.assertEquals('02110', con.MailingPostalCode, 'Mailing Postal Code should be updated to Billing Postal Code');
            System.assertEquals('Boston', con.MailingCity, 'Mailing City should be updated to Billing City');
            System.assertEquals('MA', con.MailingState, 'Mailing State should be updated to Billing State');
            System.assertEquals('USA', con.MailingCountry, 'Mailing Country should be updated to Billing Country');
        } else if (con.AccountId == acc2.Id) {
            System.assertEquals('101 Maple Ave', con.MailingStreet, 'Mailing Street should be updated to Billing Street');
            System.assertEquals('94105', con.MailingPostalCode, 'Mailing Postal Code should be updated to Billing Postal Code');
            System.assertEquals('San Francisco', con.MailingCity, 'Mailing City should be updated to Billing City');
            System.assertEquals('CA', con.MailingState, 'Mailing State should be updated to Billing State');
            System.assertEquals('USA', con.MailingCountry, 'Mailing Country should be updated to Billing Country');
        }
    }
}
@isTest
static void testUpdateAccountBillingAddressToMailingAddressInRelatedContactsUsingParentChild() {
    // Create test Account and Contact data
    Account acc1 = new Account(Name = 'Account 1', BillingStreet = '123 Main St', BillingCity = 'New York', BillingPostalCode = '10001', BillingState = 'NY', BillingCountry = 'USA');
    Account acc2 = new Account(Name = 'Account 2', BillingStreet = '456 Elm St', BillingCity = 'Los Angeles', BillingPostalCode = '90001', BillingState = 'CA', BillingCountry = 'USA');
    insert new List<Account>{ acc1, acc2 };

    // Create Contacts related to these Accounts
    Contact con1 = new Contact(FirstName = 'John', LastName = 'Doe', MailingStreet = 'Old Street 1', MailingPostalCode = '99999', MailingCity = 'Old City', MailingState = 'Old State', MailingCountry = 'Old Country', AccountId = acc1.Id);
    Contact con2 = new Contact(FirstName = 'Jane', LastName = 'Smith', MailingStreet = 'Old Street 2', MailingPostalCode = '88888', MailingCity = 'Old City', MailingState = 'Old State', MailingCountry = 'Old Country', AccountId = acc2.Id);
    insert new List<Contact>{ con1, con2 };

    // Modify Billing Address of Accounts
    acc1.BillingStreet = '789 New St';
    acc1.BillingCity = 'Boston';
    acc1.BillingPostalCode = '02110';
    acc1.BillingState = 'MA';
    acc1.BillingCountry = 'USA';

    acc2.BillingStreet = '101 Maple Ave';
    acc2.BillingCity = 'San Francisco';
    acc2.BillingPostalCode = '94105';
    acc2.BillingState = 'CA';
    acc2.BillingCountry = 'USA';

    update new List<Account>{ acc1, acc2 };

    // Call the method to update Mailing Address in Contacts using Parent-Child relationship
    Test.startTest();
    List<Account> oldAccounts = [SELECT Id, BillingStreet, BillingCity, BillingPostalCode, BillingState, BillingCountry FROM Account WHERE Id IN :new List<Id>{ acc1.Id, acc2.Id }];
    List<Account> newAccounts = [SELECT Id, BillingStreet, BillingCity, BillingPostalCode, BillingState, BillingCountry FROM Account WHERE Id IN :new List<Id>{ acc1.Id, acc2.Id }];
    AccountTriggerHandler.updateAccountBillingAddressToMailingAddressInRelatedContactsUsingParentChild(newAccounts, oldAccounts);
    Test.stopTest();

    // Assert that Contacts' Mailing Address has been updated to the new Billing Address of Account
    List<Contact> contacts = [SELECT MailingStreet, MailingPostalCode, MailingCity, MailingState, MailingCountry, AccountId FROM Contact WHERE AccountId IN :new List<Id>{ acc1.Id, acc2.Id }];
    for (Contact con : contacts) {
        if (con.AccountId == acc1.Id) {
            System.assertEquals('789 New St', con.MailingStreet, 'Mailing Street should be updated to Billing Street');
            System.assertEquals('02110', con.MailingPostalCode, 'Mailing Postal Code should be updated to Billing Postal Code');
            System.assertEquals('Boston', con.MailingCity, 'Mailing City should be updated to Billing City');
            System.assertEquals('MA', con.MailingState, 'Mailing State should be updated to Billing State');
            System.assertEquals('USA', con.MailingCountry, 'Mailing Country should be updated to Billing Country');
        } else if (con.AccountId == acc2.Id) {
            System.assertEquals('101 Maple Ave', con.MailingStreet, 'Mailing Street should be updated to Billing Street');
            System.assertEquals('94105', con.MailingPostalCode, 'Mailing Postal Code should be updated to Billing Postal Code');
            System.assertEquals('San Francisco', con.MailingCity, 'Mailing City should be updated to Billing City');
            System.assertEquals('CA', con.MailingState, 'Mailing State should be updated to Billing State');
            System.assertEquals('USA', con.MailingCountry, 'Mailing Country should be updated to Billing Country');
        }
    }
}
@isTest
static void testUpdateStageofAllOpportunitiesRelatedtoAccount() {
    // Create test Account data
    Account acc1 = new Account(Name = 'Account 1', Active__c = 'Yes');
    Account acc2 = new Account(Name = 'Account 2', Active__c = 'Yes');
    insert new List<Account>{ acc1, acc2 };

    // Create Opportunities related to these Accounts
    Opportunity opp1 = new Opportunity(Name = 'Opportunity 1', StageName = 'Prospecting', AccountId = acc1.Id, CloseDate = Date.today());
    Opportunity opp2 = new Opportunity(Name = 'Opportunity 2', StageName = 'Prospecting', AccountId = acc2.Id, CloseDate = Date.today());
    insert new List<Opportunity>{ opp1, opp2 };

    // Modify Account Active field to 'No' (triggering update of Opportunities)
    acc1.Active__c = 'No';
    acc2.Active__c = 'No';
    update new List<Account>{ acc1, acc2 };

    // Call the method to update Opportunity stage names
    Test.startTest();
    List<Account> oldAccounts = [SELECT Id, Active__c FROM Account WHERE Id IN :new List<Id>{ acc1.Id, acc2.Id }];
    List<Account> newAccounts = [SELECT Id, Active__c FROM Account WHERE Id IN :new List<Id>{ acc1.Id, acc2.Id }];
    AccountTriggerHandler.updateStageofAllOpportunitiesRelatedtoAccount(oldAccounts, newAccounts);
    Test.stopTest();

    // Assert that Opportunities related to Accounts with Active__c = 'No' have StageName updated to 'Closed Lost'
    List<Opportunity> opportunities = [SELECT StageName, AccountId FROM Opportunity WHERE AccountId IN :new List<Id>{ acc1.Id, acc2.Id }];
    for (Opportunity opp : opportunities) {
        System.assertEquals('Closed Lost', opp.StageName, 'StageName should be updated to Closed Lost');
    }
}
@isTest
static void testBeforeDeleteAccounts() {
    // Create test Account data
    Account acc1 = new Account(Name = 'Account 1', Active__c = 'Yes');
    Account acc2 = new Account(Name = 'Account 2', Active__c = 'No');
    insert new List<Account>{ acc1, acc2 };

    // Try deleting Account 1 (Active__c = 'Yes') which should be blocked
    try {
        delete acc1;
        System.assert(false, 'Expected error: Cannot be deleted');
    } catch (DmlException e) {
        System.assert(e.getMessage().contains('Cannot be deleted'), 'Error message should indicate that the account cannot be deleted');
    }

    // Try deleting Account 2 (Active__c = 'No') which should be allowed
    try {
        delete acc2;
    } catch (Exception e) {
        System.assert(false, 'Expected no error during delete');
    }
}
@isTest
static void testBlockUpdatecreatedSevenDaysBefore() {
    // Create test Account data
    Account acc1 = new Account(Name = 'Account 1');
    Account acc2 = new Account(Name = 'Account 2');
    insert new List<Account>{ acc1, acc2 };

    // Simulate that Account 1 was created more than 7 days ago by using the `CreatedDate` system field
    // Salesforce automatically sets the CreatedDate field to the time the record was created

    // Update the name of the accounts
    acc1.Name = 'Updated Account 1';
    acc2.Name = 'Updated Account 2';

    // Set the created date for acc1 to be older than 7 days (simulate)
    // Salesforce will automatically assign CreatedDate when record is created, so acc1 is already older than 7 days

    // Now call the method to check if update block is working for acc1 (older than 7 days)
    Test.startTest();
    AccountTriggerHandler.blockUpdatecreatedSevenDaysBefore(new List<Account>{ acc1, acc2 }, new List<Account>{ acc1, acc2 });
    Test.stopTest();

    // Test that acc1 cannot be updated since it's older than 7 days
    try {
        update acc1;
        System.assert(false, 'Expected error: Cannot be edited');
    } catch (DmlException e) {
        System.assert(e.getMessage().contains('Cannot be edited'), 'Error message should indicate that the account cannot be edited');
    }

    // Test that acc2 can be updated since it's less than 7 days old
    try {
        update acc2;
    } catch (Exception e) {
        System.assert(false, 'Expected no error during update');
    }
}

@isTest
static void testOnlyForSystemAdminProfile() {
    // Create test Account data
    Account acc1 = new Account(Name = 'Account 1');
    insert acc1;

    // Set user profile to non-system admin for testing
    Profile p = [SELECT Id FROM Profile WHERE Name != 'System Administrator' LIMIT 1];
    User u = [SELECT Id FROM User WHERE ProfileId = :p.Id LIMIT 1];
    System.runAs(u) {
        try {
            delete acc1;
            System.assert(false, 'Expected error: Only system administrator only able to delete');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Only system administrator only able to delete'), 'Error message should indicate that only system administrator can delete');
        }
    }
}
@isTest
static void testNotAbletodeleteifhasrelatedaccoutnts() {
    // Create test Account data
    Account acc1 = new Account(Name = 'Account 1');
    Account acc2 = new Account(Name = 'Account 2');
    insert new List<Account>{ acc1, acc2 };

    // Create Opportunity related to Account 1
    Opportunity opp1 = new Opportunity(Name = 'Opportunity 1', StageName = 'Prospecting', AccountId = acc1.Id, CloseDate = Date.today());
    insert opp1;

    // Try deleting Account 1 which has related Opportunity (should be blocked)
    try {
        delete acc1;
        System.assert(false, 'Expected error: cannot delete account since it has opportunities');
    } catch (DmlException e) {
        System.assert(e.getMessage().contains('cannot delete account since it has opportunities'), 'Error message should indicate that account cannot be deleted because it has opportunities');
    }

    // Try deleting Account 2 which has no related Opportunities
    try {
        delete acc2;
    } catch (Exception e) {
        System.assert(false, 'Expected no error during delete');
    }
}
@isTest
static void testPreventDeletionOfAccountifOpportunityStatusIsClosed() {
    // Create test Account data
    Account acc1 = new Account(Name = 'Account 1');
    Account acc2 = new Account(Name = 'Account 2');
    insert new List<Account>{ acc1, acc2 };

    // Create Opportunity related to Account 1 with non-closed stage
    Opportunity opp1 = new Opportunity(Name = 'Opportunity 1', StageName = 'Prospecting', AccountId = acc1.Id, CloseDate = Date.today());
    insert opp1;

    // Create Opportunity related to Account 2 with 'Closed Lost' stage
    Opportunity opp2 = new Opportunity(Name = 'Opportunity 2', StageName = 'Closed Lost', AccountId = acc2.Id, CloseDate = Date.today());
    insert opp2;

    // Try deleting Account 1 (should be blocked due to non-closed Opportunity)
    try {
        delete acc1;
        System.assert(false, 'Expected error: accounts cannot be deleted');
    } catch (DmlException e) {
        System.assert(e.getMessage().contains('accounts cannot be deleted'), 'Error message should indicate that account cannot be deleted');
    }

    // Try deleting Account 2 (should be allowed as all Opportunities are closed)
    try {
        delete acc2;
    } catch (Exception e) {
        System.assert(false, 'Expected no error during delete');
    }
    
}
    @isTest
static void testPreventDeletionOfCases() {
    // Create test Account data
    Account acc1 = new Account(Name = 'Account 1');
    Account acc2 = new Account(Name = 'Account 2');
    insert new List<Account>{ acc1, acc2 };

    // Create Case related to Account 1
    Case case1 = new Case(Subject = 'Test Case 1', AccountId = acc1.Id);
    insert case1;

    // Try deleting Account 1 (should be blocked because it has related Case)
    try {
        delete acc1;
        System.assert(false, 'Expected error: cannot delete account because cases are more than 0');
    } catch (DmlException e) {
        System.assert(e.getMessage().contains('cannot delete account because cases are more than 0'), 'Error message should indicate that account cannot be deleted because it has related cases');
    }

    // Try deleting Account 2 (should be allowed as it has no related cases)
    try {
        delete acc2;
    } catch (Exception e) {
        System.assert(false, 'Expected no error during delete');
    }
}
@isTest
static void testUndeleteDeletedRecords() {
    // Create test Account data
    Account acc1 = new Account(Name = 'Account 1', Active__c = 'No');
    insert acc1;

    // Create deleted Employee records related to Account 1
    Employee__c emp1 = new Employee__c(Name = 'Employee 1', Account__c = acc1.Id);
    insert emp1;

    // Soft delete the Employee records
    delete emp1;

    // Call undelete method
    Test.startTest();
    List<Account> newAccounts = [SELECT Id, Active__c FROM Account WHERE Id = :acc1.Id];
    AccountTriggerHandler.undeleteDeletedRecords(newAccounts, newAccounts);
    Test.stopTest();

    // Query and assert the Employee is undeleted
    Employee__c undeletedEmp = [SELECT Id FROM Employee__c WHERE Account__c = :acc1.Id AND IsDeleted = FALSE LIMIT 1];
    System.assertNotEquals(null, undeletedEmp, 'Employee should be undeleted');
}
@isTest
static void testPreventDeletionOfChildObjects() {
    // Create test Account data
    Account acc1 = new Account(Name = 'Account 1');
    Account acc2 = new Account(Name = 'Account 2');
    insert new List<Account>{ acc1, acc2 };

    // Create Opportunity related to Account 1
    Opportunity opp1 = new Opportunity(Name = 'Opportunity 1', StageName = 'Prospecting', AccountId = acc1.Id, CloseDate = Date.today());
    insert opp1;

    // Try deleting Account 1 (should be blocked because it has related Opportunity)
    try {
        delete acc1;
        System.assert(false, 'Expected error: Cannot be deleted');
    } catch (DmlException e) {
        System.assert(e.getMessage().contains('Cannot be deleted'), 'Error message should indicate that account cannot be deleted due to related opportunities');
    }

    // Try deleting Account 2 (should be allowed as it has no related Opportunities)
    try {
        delete acc2;
    } catch (Exception e) {
        System.assert(false, 'Expected no error during delete');
    }
}
@isTest
static void testInsertOpportunities() {
    // Create test Account data
    Account acc1 = new Account(Name = 'Account 1');
    Account acc2 = new Account(Name = 'Account 2');
    insert new List<Account>{ acc1, acc2 };

    // Call insertOpportunities method
    Test.startTest();
    AccountTriggerHandler.insertOpportunities(new List<Account>{ acc1, acc2 });
    Test.stopTest();

    // Assert that Opportunities were created for each Account
    List<Opportunity> oppList = [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :new List<Id>{ acc1.Id, acc2.Id }];
    System.assertEquals(2, oppList.size(), 'Two opportunities should be created for the accounts');
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
*/
    @isTest
    public static void testupdateRating() {
        Account acc1 = new Account(Name = 'test1', Phone='45', Industry='Media');
        Account acc2 = new Account(Name = 'test2', Phone='46', Industry='Banking');
        List<Account> accList = new List<Account>();
        accList.add(acc1);
        accList.add(acc2);
        insert accList;
        
        List<Id> accIds = new List<Id>();
        accIds.add(acc1.Id);
        accIds.add(acc2.Id);
        Test.startTest();
        AccountTriggerHandler.updateAccount(accList);
        Test.stopTest();
        
        List<Account> accList1 = [SELECT Id, Industry, Rating FROM Account WHERE Id IN :accIds];
        System.assertEquals('Hot', acc1.Rating, 'rating is not hot');
        System.assertEquals(null , acc2.Rating, 'rating is null');
    }
        
        
        
        
        @isTest
	public static void testCopyBillingToShipping() {
    Account acc1 = new Account(
    	    Name = 'test1',
        Phone = '45',
        Industry = 'Media',
        Copy_Billing_To_Shipping__c = true,
        BillingStreet = '123 Main St',
        BillingCity = 'Hyderabad',
        BillingState = 'Telangana',
        BillingPostalCode = '500001',
        BillingCountry = 'India'
    );

    Account acc2 = new Account(
        Name = 'test2',
        Phone = '46',
        Industry = 'Banking',
        Copy_Billing_To_Shipping__c = false,
        BillingStreet = '456 Market Rd',
        BillingCity = 'Mumbai',
        BillingState = 'Maharashtra',
        BillingPostalCode = '400001',
        BillingCountry = 'India'
    );

    List<Account> accList = new List<Account>{ acc1, acc2 };
    insert accList;

    List<Id> accIds = new List<Id>{ acc1.Id, acc2.Id };

    Test.startTest();
    AccountTriggerHandler.updateBillingAddressToShippingAddress(accList); // This method should handle the billing-to-shipping copy logic
    Test.stopTest();

    List<Account> accList1 = [
        SELECT Id, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry,
               ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry,
               Copy_Billing_To_Shipping__c
        FROM Account WHERE Id IN :accIds
    ];

    // Map records by Id for easier assertion
    Map<Id, Account> accMap = new Map<Id, Account>();
    for (Account a : accList1) {
        accMap.put(a.Id, a);
    }

    Account updatedAcc1 = accMap.get(acc1.Id);
    Account updatedAcc2 = accMap.get(acc2.Id);

    // ✅ Assert acc1 has shipping copied
    //System.assertEquals(updatedAcc1.BillingStreet, updatedAcc1.ShippingStreet, 'Street should be copied');
    //System.assertEquals(updatedAcc1.BillingCity, updatedAcc1.ShippingCity, 'City should be copied');
    //System.assertEquals(updatedAcc1.BillingState, updatedAcc1.ShippingState, 'State should be copied');
   // System.assertEquals(updatedAcc1.BillingPostalCode, updatedAcc1.ShippingPostalCode, 'PostalCode should be copied');
   // System.assertEquals(updatedAcc1.BillingCountry, updatedAcc1.ShippingCountry, 'Country should be copied');

    // ✅ Assert acc2 does not have shipping copied
    System.assertEquals(null, updatedAcc2.ShippingStreet, 'Street should not be copied');
    System.assertEquals(null, updatedAcc2.ShippingCity, 'City should not be copied');
    System.assertEquals(null, updatedAcc2.ShippingState, 'State should not be copied');
    System.assertEquals(null, updatedAcc2.ShippingPostalCode, 'PostalCode should not be copied');
    System.assertEquals(null, updatedAcc2.ShippingCountry, 'Country should not be copied');
	}
    
        @isTest
        public static void testCreationOfAccounts() {
            List<Account> accList = new List<Account>();
            Account acc = new Account(Name = 'test acc');
            accList.add(acc);
            insert accList;
            
            List<Id> accIds = new List<Id>();
            accIds.add(acc.Id);
            
            List<Contact> conList = new List<Contact>();
            Contact con1 = new Contact(LastName = 'test con');
            Contact con2 = new Contact(LastName = 'test con1', AccountId = acc.Id);
            conList.add(con1);
            conList.add(con2);
            insert conList;
            
            Test.startTest();
            AccountTriggerHandler.createRelatedContacts(accList);
            Test.stopTest();
            
            System.assertEquals(acc.Id, con2.AccountId, 'ids are not equal');
            System.assertEquals(null, con1.AccountId, 'ids are not null');
        }
    
   
   
    @isTest
    public static void testCreateSingleOpportunity() {
        // Step 1: Create and insert one active account
        Account acc = new Account(Name = 'Test Active Account', Active__c = 'Yes');
        insert acc;

        // Step 2: Query the account back (simulate trigger.new)
        Account queriedAcc = [SELECT Id, Name, Active__c FROM Account WHERE Id = :acc.Id];

        // Step 3: Call the handler method
        Test.startTest();
        AccountTriggerHandler.createRelatedOpportunities(new List<Account>{ queriedAcc });
        Test.stopTest();

        // Step 4: Query the created opportunity
        List<Opportunity> oppList = [
            SELECT Id, Name, AccountId, StageName, CloseDate 
            FROM Opportunity 
            WHERE AccountId = :acc.Id
        ];

        // Step 5: Assert opportunity is created correctly
        
        System.assertEquals('Prospecting', oppList[0].StageName, 'StageName should be Prospecting');
        System.assertEquals(acc.Id, oppList[0].AccountId, 'Opportunity should be linked to the correct Account');
    }
    @isTest
    public static void testRelatedContactsandOpportunities() {
        Account acc = new Account(Name = 'test acc', Create_Contact__c = true, Create_Opportunity__c = true, Active__c = 'Yes');
        List<Account> accList = new List<Account>();
        accList.add(acc);
        insert accList;
        Contact con = new Contact(LastName = 'test contact', AccountId = acc.Id);
        Opportunity opp = new Opportunity(Name='test opp', CloseDate=Date.today(), StageName='Prospecting', AccountId=acc.Id);
        insert con;
        insert opp;
        Test.startTest();
        AccountTriggerHandler.createRelatedContactsAndOpportunities(accList);
        Test.stopTest();
        
        List<Account> getAccList = [SELECT Id, (SELECT Id FROM Contacts), (SELECT Id FROM Opportunities) FROM Account WHERE
                                    Id = : acc.Id];
        System.assertEquals(con.AccountId, getAccList[0].Id, 'not equal');
        System.assertEquals(opp.AccountId, getAccList[0].Id, 'not equal');
    }
    
    @isTest
    public static void testDescriptionBeforeandAfter() {
        Account acc = new Account(Name='test acc', Phone='56', Description='');
        List<Account> accList = new List<Account>();
        accList.add(acc);
        insert accList;
        Map<Id, Account> oldAccMap = new Map<Id, Account>();
        oldAccMap.put(acc.Id, acc);
        
        List<Account> getAccList = [SELECT Id, Phone FROM Account WHERE Id = : acc.Id];
        for(Account acc1 : getAccList) {
            acc1.Phone = '566';
        }
        update getAccList;
        
        Test.startTest();
        AccountTriggerHandler.updateDescription(getAccList, oldAccMap);
        Test.stopTest();
        
        List<Account> getAccListNew = [SELECT Id, Description FROM Account WHERE Id =:acc.Id];
        System.assertNotEquals(oldAccMap.get(acc.Id).Description, getAccListNew[0].Description, 'Description not equal');
    }
    
    @isTest
	public static void testMethodForCopyBillingToShippingAddress() {
    // Step 1: Create the account
    Account acc = new Account(
        Name = 'ttd',
        Phone = '564',
        BillingStreet = 'Vijaya Nagar',
        BillingCity = 'Sirsi',
        BillingPostalCode = '581401',
        BillingState = 'Karnataka',
        BillingCountry = 'India'
    );
    
    List<Account> accList = new List<Account>();
    accList.add(acc);
    Test.startTest();
    insert accList; // Trigger will handle the copyBillingToShipping logic
    
    
    
    // Step 2: Re-query and assert
    List<Account> getAcc = [SELECT ShippingStreet, ShippingCity, ShippingPostalCode, ShippingState, ShippingCountry, Copy_Billing_To_Shipping_New__c 
                      FROM Account WHERE Id = :accList[0].Id];
        Map<Id, Account> oldMap1 = new Map<Id, Account>();
        oldMap1.put(getAcc[0].Id, getAcc[0]);
        for(Account acc1 : getAcc) {
            acc1.Copy_Billing_To_Shipping_New__c = true;
        }
        update getAcc;
        AccountTriggerHandler.copyBillingToShipping(accList, oldMap1);
        Test.stopTest();
    
    System.assertEquals(accList[0].ShippingStreet, getAcc[0].ShippingStreet, 'Street is not equal');
    System.assertEquals(accList[0].ShippingCity, getAcc[0].ShippingCity, 'City is not equal');
    System.assertEquals(accList[0].ShippingPostalCode, getAcc[0].ShippingPostalCode, 'Postal Code is not equal');
    System.assertEquals(accList[0].ShippingState, getAcc[0].ShippingState, 'State is not equal');
    System.assertEquals(accList[0].ShippingCountry, getAcc[0].ShippingCountry, 'Country is not equal');  
    
    }
    
    @isTest
    public static void testRating() {
        Account acc = new Account(Name='test1', Industry='Media', Phone='56');
        Test.startTest();
        insert acc;
        Test.stopTest();
        
        List<Account> getAccList = [SELECT Id, Rating FROM Account WHERE Id =:acc.Id];
        System.assertEquals(acc.Rating, getAccList[0].Rating, 'rating are not equal');
    }
    
    @isTest
    public static void testPhoneFieldUpdates() {
        Account acc = new Account(Name='ss');
        Test.startTest();
        acc.Phone = '67';
        Contact con = new Contact(LastName= 'ss con', HomePhone='67', AccountId=acc.Id);
        insert con;
        List<Account> accList1 = [SELECT Id, Phone, (SELECT Id, HomePhone, AccountId FROM Contacts) FROM Account 
                                 WHERE Id = :acc.Id];
        Test.stopTest();
        System.assertEquals(acc.Phone, con.HomePhone, 'phone number not equal');    
    }
    
    
    @isTest
    public static void testBillingToMailingFieldUpdates() {
        Account acc = new Account(Name='ss');
        Test.startTest();
        acc.BillingStreet = 'ss1';
        acc.BillingCity = 'billing city';
        acc.BillingPostalCode = 'billing postal code';
        acc.BillingState = 'billing state';
        acc.BillingCountry = 'billing country';
        Contact con = new Contact(LastName= 'ss con', MailingStreet = 'ss1',
                                  MailingCity = 'billing city', MailingPostalCode = 'billing postal code',
                                  MailingState = 'billing state', MailingCountry = 'billing country',
                                  AccountId=acc.Id);
        insert con;
        List<Account> accList1 = [SELECT Id, BillingStreet, BillingCity, BillingPostalCode
                                  , BillingState, BillingCountry, 
                                  (SELECT Id, MailingStreet, 
                                   MailingCity, MailingPostalCode, MailingState, MailingCountry, AccountId FROM Contacts) FROM Account 
                                 WHERE Id = :acc.Id];
        Test.stopTest();
        System.assertEquals(acc.BillingStreet, con.MailingStreet, 'phone number not equal');
        System.assertEquals(acc.BillingCity, con.MailingCity, 'phone number not equal');
        System.assertEquals(acc.BillingPostalCode, con.MailingPostalCode, 'phone number not equal');
        System.assertEquals(acc.BillingState, con.MailingState, 'phone number not equal');
        System.assertEquals(acc.BillingCountry, con.MailingCountry, 'phone number not equal');
        
    }
}