public class RectangleWithStaticMethod {
    public static Decimal area(Decimal length, Decimal breadth) {
        Decimal a = (length * breadth);
        return a;
    }
    
    public static Decimal perimeter(Decimal length, Decimal breadth) {
        Decimal p = 2 * (length + breadth);
        return p;
    }
}