public class ListDemo {
    public static void listDemoMethod() {
    	String name = 'Sachin Shete';
        List<String> names = new List<String>();
        names.add('Person 1');
        names.add('Person 2');
        names.add('Person 3');
        System.debug('names list is '+names);
        
        
        Set<Integer> numSet = new Set<Integer>();
        List<Integer> numbers = new List<Integer>();
        numSet.add(1);
        System.debug('list contains 1' +numSet.contains(1));
        numSet.add(2);
        numSet.add(3);
        System.debug('number set is' +numSet);
        numbers.add(10);
        numbers.add(20);
        numbers.add(30);
        numbers.add(40);
        numbers.add(40);
        numbers.add(50);
        numbers.add(1, 100);
        System.debug('numbers list is'+numbers);
        numbers.addAll(numset);
        System.debug('numbers list after adding numset'+numbers);
        Set<Integer> newSet = new Set<Integer>{1,2,3,4};
        numbers.addAll(newSet);
        System.debug('after adding set'+numbers);
        List<Integer> newList = new List<Integer>();
        newList = numbers.clone();
        System.debug('new list is '+newList);
        newList.clear();
        System.debug('new list clear is'+newList);
        List<Integer> list1 = new List<Integer>{1,2,3,4};
            List<Integer> list2 = new List<Integer>{1,2,3,4};
        list1.equals(list2);
        System.debug('list1 equals list2,'+list1.equals(list2));

        
    }
}