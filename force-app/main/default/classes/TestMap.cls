public class TestMap {
    public static void testMethods() {
        List<Account> listacc = [select Id, name from Account LIMIT 5];
        System.debug(listacc);
    }
}