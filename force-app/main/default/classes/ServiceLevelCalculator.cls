public class ServiceLevelCalculator {
    public static Integer getMaxResponseTime(String customerTier) {
        Support_Service_Level__mdt serviceLevel = [SELECT Maximum_Response_Time__c FROM Support_Service_Level__mdt WHERE Customer_Tier__c = : customerTier];
        System.debug('good morning');
        return serviceLevel != null? Integer.valueOf(serviceLevel.Maximum_Response_Time__c) : 72;
    }
    public static void setTargetResponseTime(Case caseRecord) {
        String customerTier = caseRecord.Customer_Tier_Custom__c;
        
        Integer responseTimeInHours = getMaxResponseTime(customerTier);
        caseRecord.Target_Response_Time__c = responseTimeInHours; 
    }
}