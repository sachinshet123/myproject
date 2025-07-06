public class Square {
	Decimal side = 50;
    public void area1() {
        Decimal a = side*side;
        System.debug(a);
    }
    public void circum() {
        Decimal cr = 4*side;
        System.debug(cr);
    }
}