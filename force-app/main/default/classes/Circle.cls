public class Circle {
final Decimal pi = 3.142,r;
    public Circle(Decimal radius) {
        r = radius;
    }
    public void area() {
        Decimal a = 2*pi*r*r;
        System.debug(a);
    }
    public void circum() {
        Decimal cir = 2*pi*r;
        System.debug(cir);
    }
}