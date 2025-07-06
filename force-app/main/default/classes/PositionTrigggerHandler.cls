public class PositionTrigggerHandler {
    public static void populateWithTheBasicDetails(List<Position__c> posList) {
        Date todayDate = Date.today();
        for(Position__c pos : posList) {
            	pos.Open_Date__c = todayDate;
                pos.Min_Pay__c = 10000;
                pos.Max_Pay__c = 15000;
        }
    }
}