@isTest
private class OpportunityHelperTest {

    @isTest
    static void testCalculateTotalWonAmount() {
        // Create a test account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Create test opportunities related to the test account
        Opportunity opp1 = new Opportunity(Name = 'Test Opportunity 1', StageName = 'Closed Won', Amount = 1000, AccountId = testAccount.Id);
        Opportunity opp2 = new Opportunity(Name = 'Test Opportunity 2', StageName = 'Closed Won', Amount = 2000, AccountId = testAccount.Id);
        Opportunity opp3 = new Opportunity(Name = 'Test Opportunity 3', StageName = 'Closed Lost', Amount = 3000, AccountId = testAccount.Id);
        insert new List<Opportunity>{opp1, opp2, opp3};
        
        // Call the calculateTotalWonAmount method and verify the result
        Decimal totalWonAmount = OpportunityHelper.calculateTotalWonAmount(testAccount.Id);
        System.assertEquals(3000, totalWonAmount);
    }

    @isTest
    static void testUpdateOpportunityStage() {
        // Create a test opportunity
        Opportunity testOpportunity = new Opportunity(Name = 'Test Opportunity', StageName = 'Prospecting', Amount = 500, CloseDate = Date.today());
        insert testOpportunity;

        // Call the updateOpportunityStage method to update the stage
        OpportunityHelper.updateOpportunityStage(testOpportunity.Id, 'Closed Won');

        // Retrieve the updated opportunity
        Opportunity updatedOpportunity = [SELECT StageName FROM Opportunity WHERE Id = :testOpportunity.Id LIMIT 1];

        // Verify that the stage has been updated
        System.assertEquals('Closed Won', updatedOpportunity.StageName);
    }
}