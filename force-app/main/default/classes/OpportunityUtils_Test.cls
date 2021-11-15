@isTest
private class OpportunityUtils_Test 
{
    // update this class to unit test the OpportunityUtils class. 
    // Ensure that you create positive and negative test cases
    // as appropriate, and take into account any boundaries.

    // 100% coverage can be achieved without testing all scenarios,
    // so don't stop just because you have full coverage.

    /****************************
     * Positive Test Cases
     ****************************/

    @isTest static void test_addOpportunitySizeToNameAndSave_TestLarge_Insert()
    {
        // test setup - 1 opp with amount > 100000
        Opportunity testOpp = TestDataHelper.GetOpportunity(100000.01); 

        Test.startTest();

        OpportunityUtils OpportunityUtils = new OpportunityUtils();
        OpportunityUtils.addOpportunitySizeToNameAndSave(new List<Opportunity>{testOpp});

        Test.stopTest();
        
        List<Opportunity> Opps = [SELECT name FROM Opportunity];
        System.assert(Opps[0].name.endsWith('Large'), 'The opportunity name should end with \'Large\'');
    }

    @isTest static void test_addOpportunitySizeToNameAndSave_TestLarge_Update()
    {
        // test setup - 1 opp with amount > 100000
        Opportunity testOpp = TestDataHelper.GetOpportunity(100000.01); 
        insert testOpp;

        Test.startTest();

        OpportunityUtils OpportunityUtils = new OpportunityUtils();
        OpportunityUtils.addOpportunitySizeToNameAndSave(new List<Opportunity>{testOpp});

        Test.stopTest();
        
        List<Opportunity> Opps = [SELECT name FROM Opportunity];
        System.assert(Opps[0].name.endsWith('Large'), 'The opportunity name should end with \'Large\'');
    }

    @isTest static void test_addOpportunitySizeToNameAndSave_TestMedium()
    {
        // test setup - 1 opp with amount > 50000 <= 1000000
        Opportunity testOpp = TestDataHelper.GetOpportunity(100000.00); 
        insert testOpp;

        Test.startTest();

        OpportunityUtils OpportunityUtils = new OpportunityUtils();
        OpportunityUtils.addOpportunitySizeToNameAndSave(new List<Opportunity>{testOpp});

        Test.stopTest();
        
        List<Opportunity> Opps = [SELECT name FROM Opportunity];
        System.assert(Opps[0].name.endsWith('Medium'), 'The opportunity name should end with \'Medium\'');
    }

    @isTest static void test_addOpportunitySizeToNameAndSave_TestSmall()
    {
        // test setup - 1 opp with amount <= 50000
        Opportunity testOpp = TestDataHelper.GetOpportunity(50000.00); 
        insert testOpp;

        Test.startTest();

        OpportunityUtils OpportunityUtils = new OpportunityUtils();
        OpportunityUtils.addOpportunitySizeToNameAndSave(new List<Opportunity>{testOpp});

        Test.stopTest();
        
        List<Opportunity> Opps = [SELECT name FROM Opportunity];
        System.assert(Opps[0].name.endsWith('Small'), 'The opportunity name should end with \'Small\'');
    }

    @isTest static void test_addOpportunitySizeToNameAndSave_Bulk()
    {
        // test setup - 200 opps with amount > 100000
        List<Opportunity> testOpps = new List<Opportunity>();
        for (Integer i=1; i<=200; i++)
        {
            Decimal amount = 100000.00 + i;
            Opportunity testOpp = TestDataHelper.GetOpportunity(amount); 
            testOpps.add(testOpp);
        }
        insert testOpps;
        
        Test.startTest();

        OpportunityUtils OpportunityUtils = new OpportunityUtils();
        OpportunityUtils.addOpportunitySizeToNameAndSave(testOpps);

        Test.stopTest();
        
        List<Opportunity> Opps = [SELECT name FROM Opportunity];
        System.assertEquals(200,Opps.Size(), '200 opportunities should have been updated');
        for (Integer i=0; i<200; i++)
        {
            System.assert(Opps[i].name.endsWith('Large'), 'The opportunity name should end with \'Large\'');
        }
    }

    @isTest static void test_addOpportunitySizeToNameAndSave_InsertAndUpdate()
    {
        // test setup - 2 opps with amount > 100000
        Opportunity testOpp1 = TestDataHelper.GetOpportunity(100000.01); 
        Opportunity testOpp2 = TestDataHelper.GetOpportunity(100000.02); 
        insert testOpp1;

        Test.startTest();
  
        OpportunityUtils OpportunityUtils = new OpportunityUtils();
        OpportunityUtils.addOpportunitySizeToNameAndSave(new List<Opportunity>{testOpp1,testOpp2});
  
        Test.stopTest();
          
        List<Opportunity> Opps = [SELECT name FROM Opportunity];
        System.assert(Opps[0].name.endsWith('Large'), 'The opportunity name should end with \'Large\'');
        System.assert(Opps[1].name.endsWith('Large'), 'The opportunity name should end with \'Large\'');
    }

    /****************************
     * Negative Test Cases
     ****************************/

    @isTest static void test_addOpportunitySizeToNameAndSave_NullAmount()
    {
         // test setup - 1 opp with null amount
         Opportunity testOpp = TestDataHelper.GetOpportunity(null); 

         Test.startTest();
 
         OpportunityUtils OpportunityUtils = new OpportunityUtils();
         OpportunityUtils.addOpportunitySizeToNameAndSave(new List<Opportunity>{testOpp});
 
         Test.stopTest();
         
         List<Opportunity> Opps = [SELECT name FROM Opportunity];
         System.assertEquals(testOpp.name, Opps[0].name, 'The opportunity name should not have been upserted');
    }

    @isTest static void test_addOpportunitySizeToNameAndSave_EmptyList()
    {
        Test.startTest();
 
        OpportunityUtils OpportunityUtils = new OpportunityUtils();
        OpportunityUtils.addOpportunitySizeToNameAndSave(new List<Opportunity>());
 
        Test.stopTest();
         
        List<Opportunity> Opps = [SELECT name FROM Opportunity];
        System.assertEquals(0, Opps.Size(), 'No Opportunities should have been upserted');

    }

    @isTest static void test_addOpportunitySizeToNameAndSave_NullInList()
    {
        // test setup - 2 opps with amount > 100000
        Opportunity testOpp1 = TestDataHelper.GetOpportunity(100000.01); 
        Opportunity testOpp2 = TestDataHelper.GetOpportunity(100000.02); 
        
        List<Opportunity> testOpps = new List<Opportunity>{testOpp1, null, testOpp2};

        Test.startTest();
 
        OpportunityUtils OpportunityUtils = new OpportunityUtils();
        OpportunityUtils.addOpportunitySizeToNameAndSave(testOpps);
 
        Test.stopTest();
         
        List<Opportunity> Opps = [SELECT name FROM Opportunity];
        System.assertEquals(2, Opps.Size(), '2 opportunities should have been upserted');

    }

    @isTest static void test_addOpportunitySizeToNameAndSave_NullList()
    {
               
        Test.startTest();
 
        OpportunityUtils OpportunityUtils = new OpportunityUtils();
        OpportunityUtils.addOpportunitySizeToNameAndSave(null);
 
        Test.stopTest();
         
        List<Opportunity> Opps = [SELECT name FROM Opportunity];
        System.assertEquals(0, Opps.Size(), 'No opportunities should have been upserted');

    }
    
}