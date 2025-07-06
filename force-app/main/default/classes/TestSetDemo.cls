public class TestSetDemo {
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
        System.debug(numbers.get(0));
        System.debug(numbers.indexOf(400));
        System.debug('numbers list is'+numbers);
        numbers.addAll(numset);
        System.debug('numset is empty'+numbers.isEmpty());
        
        System.debug('numbers list after adding numset'+numbers);
        System.debug('removed 0 index'+numbers.remove(0));
        System.debug('numbers after removing 0 index is'+numbers);
      	
      	System.debug('numbers size is '+numbers.size());
        numbers.set(5, 100);
        numbers.sort();
        Set<Integer> newSet = new Set<Integer>{100,2,3,4};
        numbers.addAll(newSet);
        System.debug('after adding set'+numbers);
        List<Integer> newList = new List<Integer>();
        newList = numbers.clone();
        System.debug('new list is '+newList);
        newList.clear();
        System.debug('new list clear is'+newList);
        List<Integer> list1 = new List<Integer>{100, 200, 2, 1};
            List<Integer> list2 = new List<Integer>{1,2,3,4};
        list1.equals(list2);
        System.debug('list1 equals list2,'+list1.equals(list2));
        list1.sort();
        list1.set(3, 2000);
        list1.remove(4); //index
        System.debug('sorted list is' +list1);// sort is mutable
            // set method
            // add()
            // addAll() for both set and list
            // contains()
            // containsAll() for both set and list
            // clear()
            // clone()
            // equals() for set
            // isEmpty()
            // remove(setElement)
            // removeAll(list of elements to remove)
            // removeAll(set of elements to remove)
            // retainAll(list of elements to retain)
            // retainAll(set of elements to retain)
    }
}