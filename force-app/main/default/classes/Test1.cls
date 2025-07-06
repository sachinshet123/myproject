public class Test1 {
    public static void testty() {
        // Initialize a Set with integers
        Set<Integer> sourceSet = new Set<Integer>{10, 20, 20, 40};

        // Initialize a pre-existing List
        List<Integer> targetList = new List<Integer>{50, 60};

        // Add all values from the Set to the List
        targetList.addAll(sourceSet);

        // Optional: Sort the List if needed
        //targetList.sort();

        // Debug output to verify the result
        System.debug('Target List after adding values from the Set: ' + targetList);
    }
}