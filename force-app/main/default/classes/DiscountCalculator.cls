public class DiscountCalculator {
	//method to retrieve percentage based on opportunity amount
    public static Decimal getDiscountPercentage(Decimal opportunityAmount) {
        //query the custom setting object list and fetch all the records of custom settings
        List<Discount_Tiers__c> discountTiers = Discount_Tiers__c.getAll().values();
        System.debug('Get All' + Discount_Tiers__c.getAll());
        System.debug('Get All Values' + Discount_Tiers__c.getAll().values());
        Decimal discountPercentage = 0;
        // traverse over the field of each custom setting app
        // because the discount are not sorted
        for(Discount_Tiers__c tier : discountTiers) {
            if(opportunityAmount >= tier.Minimum_Amount__c) {
                discountPercentage = Math.max(discountPercentage, tier.Discount_Percentage__c);
            }
        }
        return discountPercentage;
    }
    //method to calculate the discount on opportunity
    public static void applyDiscount(Opportunity opp) {
        Decimal discountPercentage = getDiscountPercentage(opp.Amount);
        Decimal discountedAmount = 0;
        discountedAmount = (opp.Amount * discountPercentage)/100;
        opp.Discount_c__c = discountedAmount;
        opp.Discount_Percentage__c = discountPercentage;
    }
}