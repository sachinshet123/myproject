@isTest
private class AwesomeCalculatorTest {
    @isTest
    static void testAddition() {
        // Set the mock response
        Test.setMock(WebServiceMock.class, new CalculatorCalloutMock());
        
        // Call the method to test
        Double result = AwesomeCalculator.add(5, 3);
        
        // Verify the result
        System.assertEquals(8, result, 'Addition result is incorrect');
    }
}