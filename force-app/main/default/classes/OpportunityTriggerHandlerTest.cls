@isTest
public class OpportunityTriggerHandlerTest {
    @isTest
    public static void testOpportunity() {
        Date todayDate = Date.today();
        
        // Create and insert Opportunities
        Opportunity opp1 = new Opportunity(Name = 'opp1', StageName = 'Prospecting', CloseDate = todayDate, Amount = 1000);
        Opportunity opp2 = new Opportunity(Name = 'opp2', StageName = 'Prospecting', CloseDate = todayDate, Amount = 1000000);
        List<Opportunity> oppList = new List<Opportunity>{ opp1, opp2 };
        
        insert oppList; // 🔴 IMPORTANT: Insert before calling handler

        Test.startTest();
        OpportunityTriggerHandler.updateDescription(oppList); // Assuming this updates records
        Test.stopTest();

        // Query updated opportunities
        List<Opportunity> updatedOppList = [
            SELECT Id, Description, Amount FROM Opportunity WHERE Id IN :oppList
        ];
        
        // Map results for cleaner assertion
        Map<Decimal, String> amountToDesc = new Map<Decimal, String>();
        for (Opportunity opp : updatedOppList) {
            amountToDesc.put(opp.Amount, opp.Description);
        }

        System.assertEquals(null, amountToDesc.get(1000), 'Description should be null for low amount');
        //System.assertEquals('Hot Opportunity', amountToDesc.get(1000000), 'Description should be "Hot Opportunity" for high amount');
    }
    
    @isTest
    public static void testUpdateRecentOpportunityAmount() {
        Account acc = new Account(Name = 'test acc');
        insert acc;
        Date todayDate = Date.newInstance(2025, 6, 20);
        Opportunity opp1 = new Opportunity(Name='test opp1', CloseDate=todayDate, StageName='Prospecting', Amount=10000, AccountId=acc.Id);
        //Opportunity opp2 = new Opportunity(Name='test opp2', CloseDate=todayDate, Stage='Prospecting', Amount=20000);
        List<Opportunity> oppList = new List<Opportunity>();
        oppList.add(opp1);
        //oppList.add(opp2);
        insert opp1;
        
        Test.startTest();
        OpportunityTriggerHandler.updateRecentOpportunityAmount(oppList);
        Test.stopTest();
        
        List<Account> updatedAccList = [SELECT Id, Recent_Opportunity_Amount_New__c FROM Account WHERE Id =:acc.Id];
        System.assertEquals(10000, updatedAccList[0].Recent_Opportunity_Amount_New__c, 'amount are not equal');
        
    }
    
    @isTest
    public static void testmethods() {
        Opportunity opp = new Opportunity(Name='opp1', CloseDate=Date.today(), StageName='Prospecting', Description='');
        Test.startTest();
        insert opp;
        Test.stopTest();
        Opportunity opp1 = [SELECT Id, Description FROM Opportunity WHERE Id = :opp.Id];
        System.assertNotEquals(opp.Description, opp1.Description, 'description are equal');
        
    }
}