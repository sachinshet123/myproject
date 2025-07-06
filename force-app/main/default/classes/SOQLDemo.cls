public class SOQLDemo {
        public static void sqlDemo() {
            List<Position__c> sObjs = new List<Position__c>([SELECT Id, Name FROM Position__c WHERE Status__c = 'Pending Approval']);
            for(Position__c  sobj : sObjs) {
                System.debug(sobj);
            }
        }
    }