public class SimpleInterest {
	Decimal principal, roi, timedu;
    public SimpleInterest(decimal p,decimal r,decimal t) {
        principal = p;
        roi=r;
        timedu=t;
    }
    public void intres() {
        Decimal intr= (principal*roi*timedu)/100;
        System.debug(intr);
    }
}