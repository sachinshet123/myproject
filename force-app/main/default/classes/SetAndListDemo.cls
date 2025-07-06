public class SetAndListDemo {
    public static void demo() {
        // Creating a Set
        Set<String> fruitSet = new Set<String>();
        fruitSet.add('Apple');
        fruitSet.add('Banana');
        fruitSet.add('Cherry');
        System.debug('Set after add(): ' + fruitSet);

        // addAll() for Set
        Set<String> anotherSet = new Set<String>{'Date', 'Elderberry'};
        fruitSet.addAll(anotherSet);
        System.debug('Set after addAll(): ' + fruitSet);

        // contains()
        System.debug('Set contains "Banana": ' + fruitSet.contains('Banana'));

        // containsAll() for Set
        System.debug('Set contains all {Apple, Cherry}: ' + fruitSet.containsAll(new Set<String>{'Apple', 'Cherry'}));

        // clear()
        fruitSet.clear();
        System.debug('Set after clear(): ' + fruitSet);

        // Clone the Set
        fruitSet.addAll(new Set<String>{'Fig', 'Grapes'});
        Set<String> clonedSet = fruitSet.clone();
        System.debug('Cloned Set: ' + clonedSet);

        // equals()
        System.debug('Is cloned set equal to original set: ' + fruitSet.equals(clonedSet));

        // isEmpty()
        System.debug('Is fruitSet empty: ' + fruitSet.isEmpty());

        // remove()
        fruitSet.remove('Grapes');
        System.debug('Set after remove("Grapes"): ' + fruitSet);

        // removeAll() with List
        List<String> fruitsToRemove = new List<String>{'Fig'};
        fruitSet.removeAll(fruitsToRemove);
        System.debug('Set after removeAll(List): ' + fruitSet);

        // removeAll() with Set
        fruitSet.addAll(new Set<String>{'Honeydew', 'Kiwi'});
        Set<String> setToRemove = new Set<String>{'Honeydew'};
        fruitSet.removeAll(setToRemove);
        System.debug('Set after removeAll(Set): ' + fruitSet);

        // retainAll() with List
        fruitSet.addAll(new Set<String>{'Lemon', 'Mango'});
        List<String> retainList = new List<String>{'Lemon'};
        fruitSet.retainAll(new Set<String>(retainList));
        System.debug('Set after retainAll(List): ' + fruitSet);

        // retainAll() with Set
        fruitSet.addAll(new Set<String>{'Orange', 'Papaya'});
        Set<String> retainSet = new Set<String>{'Papaya'};
        fruitSet.retainAll(retainSet);
        System.debug('Set after retainAll(Set): ' + fruitSet);

        // Demonstrating List methods (contains(), etc.)
        List<String> fruitList = new List<String>{'Apple', 'Banana', 'Cherry'};
        System.debug('List contains "Apple": ' + fruitList.contains('Apple'));
    }
}