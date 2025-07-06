@isTest
public class RectangleWithStaticMethodTest {

    @isTest
    public static void testArea() {
        // Test the area method
        Decimal length = 10.0;
        Decimal breadth = 5.0;
        
        // Calculate expected area manually
        Decimal expectedArea = length * breadth;
        
        // Call the static method to calculate area
        Decimal result = RectangleWithStaticMethod.area(length, breadth);

        // Assert the expected and actual values
        System.assertEquals(expectedArea, result, 'Area calculation is incorrect');
    }

    @isTest
    public static void testPerimeter() {
        // Test the perimeter method
        Decimal length = 10.0;
        Decimal breadth = 5.0;
        
        // Calculate expected perimeter manually
        Decimal expectedPerimeter = 2 * (length + breadth);
        
        // Call the static method to calculate perimeter
        Decimal result = RectangleWithStaticMethod.perimeter(length, breadth);

        // Assert the expected and actual values
        System.assertEquals(expectedPerimeter, result, 'Perimeter calculation is incorrect');
    }
}