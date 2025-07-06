@isTest
public class PositionTriggerHandlerTest {
	@isTest
    public static void testUpdateFields() {
        Date todayDate = Date.today();
        Position__c pos = new Position__c(Name = 'test');
        List<Position__c> posList = new List<Position__c>();
        posList.add(pos);
        insert posList;
        
        Test.startTest();
        PositionTrigggerHandler.populateWithTheBasicDetails(posList);
        Test.stopTest();
        
        List<Position__c> getPosList = [SELECT Id, Open_Date__c, Min_Pay__c, Max_Pay__c FROM Position__c WHERE Id IN :posList];
        
        System.assertEquals(todayDate, getPosList[0].Open_Date__c, 'date are not equal');
        System.assertEquals(10000.00, getPosList[0].Min_Pay__c, 'date are not equal');
        System.assertEquals(15000.00, getPosList[0].Max_Pay__c, 'date are not equal');
        
    }
}