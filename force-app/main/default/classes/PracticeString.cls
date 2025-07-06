public class PracticeString {
    public static void getString() {
        String accIds = '001dL00000oFDjQQAW,001dL00000oCQoLQAW';
        List<String> accIdsString = accIds.split(',');
        for(String str : accIdsString) {
            System.debug(str);
        }
    }
}