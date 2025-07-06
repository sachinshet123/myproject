@isTest
public class CalculatorTest {

    @isTest
    public static void testAddition() {
        // Test addition method
        Decimal num1 = 10.0;
        Decimal num2 = 5.0;
        
        // Expected result for addition
        Decimal expectedResult = 15.0;
        
        // Call the add method
        Decimal result = Calculator.add(num1, num2);

        // Assert that the result matches the expected result
        System.assertEquals(expectedResult, result, 'Addition calculation is incorrect');
    }

    @isTest
    public static void testSubtraction() {
        // Test subtraction method
        Decimal num1 = 10.0;
        Decimal num2 = 5.0;
        
        // Expected result for subtraction
        Decimal expectedResult = 5.0;
        
        // Call the sub method
        Decimal result = Calculator.sub(num1, num2);

        // Assert that the result matches the expected result
        System.assertEquals(expectedResult, result, 'Subtraction calculation is incorrect');
    }

    @isTest
    public static void testMultiplication() {
        // Test multiplication method
        Decimal num1 = 10.0;
        Decimal num2 = 5.0;
        
        // Expected result for multiplication
        Decimal expectedResult = 50.0;
        
        // Call the mul method
        Decimal result = Calculator.mul(num1, num2);

        // Assert that the result matches the expected result
        System.assertEquals(expectedResult, result, 'Multiplication calculation is incorrect');
    }

    @isTest
    public static void testDivision() {
        // Test division method
        Decimal num1 = 10.0;
        Decimal num2 = 5.0;
        
        // Expected result for division
        Decimal expectedResult = 2.0;
        
        // Call the div method
        Decimal result = Calculator.div(num1, num2);

        // Assert that the result matches the expected result
        System.assertEquals(expectedResult, result, 'Division calculation is incorrect');
    }
}