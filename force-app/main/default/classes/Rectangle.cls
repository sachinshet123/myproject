public class Rectangle {
Integer length, breadth;
    
    public Rectangle(Integer l, Integer b) {
        length = l;
        breadth = b;
    }
    public void area(Integer length, Integer breadth) {
        Integer a = length*breadth;
        System.debug(a);
    }
    
    public void perimeter() {
        Integer p = 2*(length+breadth);
        System.debug(p);
    }
}