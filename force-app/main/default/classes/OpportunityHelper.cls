public class OpportunityHelper {

    // Method to calculate the total amount of closed/won opportunities for a given account
    public static Decimal calculateTotalWonAmount(Id accountId) {
        Decimal totalAmount = 0;
        
        // Query for closed/won opportunities related to the specified account
        List<Opportunity> closedOpportunities = [SELECT Amount FROM Opportunity WHERE AccountId = :accountId AND IsClosed = true AND StageName = 'Closed Won'];

        // Sum up the amounts of all closed/won opportunities
        for(Opportunity opp : closedOpportunities) {
            totalAmount += opp.Amount;
        }
        
        return totalAmount;
    }
    
    // Method to update the opportunity stage
    public static void updateOpportunityStage(Id opportunityId, String newStage) {
        Opportunity opp = [SELECT Id, StageName FROM Opportunity WHERE Id = :opportunityId LIMIT 1];
        
        // Update the opportunity stage
        if(opp != null) {
            opp.StageName = newStage;
            update opp;
            //comment for testing
        }
    }
}