@isTest
public class TestDataHelper 
{
    public static Opportunity GetOpportunity(Decimal amount)
    {
        Opportunity newOpp = new Opportunity();
        newOpp.Name = 'TEST ' + amount;
        newOpp.CloseDate = Date.Today();
        newOpp.Amount = amount;
        newOpp.StageName = 'New';
        return newOpp;
    }
}