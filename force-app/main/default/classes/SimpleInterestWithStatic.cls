public class SimpleInterestWithStatic {
	static Decimal principal=100, roi=5, timedu=1;
    
    public static void intres() {
        Decimal intr= (principal*roi*timedu)/100;
        System.debug(intr);
    }
}