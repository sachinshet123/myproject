public class NewSetAndListDemo {
    public static void demoOfColors() {
        Set<String> colors = new Set<String>{'Yellow', 'Blue'};
        System.debug('Colors are' +colors);
        colors.add('Black');
        Set<String> colorsNew = new Set<String>{'Pink', 'Red', 'Aries'};
        System.debug('Colors addAll' +colors.addAll(colorsNew)); //true
        System.debug('colors is' +colors);
        System.debug('Colors contains '+colors.contains('Blue'));
        System.debug('Colors contains all ' +colors.containsAll(new Set<String>{'Pink', 'Red'}));
        System.debug('colors New is' +colorsNew);
        Set<String> cloneColors = new Set<String>();
        cloneColors = colorsNew.clone();
        System.debug('cloned colors is ' +cloneColors);
        System.debug('is equal' +colorsNew.equals(cloneColors));
        cloneColors.clear();
        System.debug('clear clone colors ' +cloneColors);
        System.debug('clone colors is empty' +cloneColors.isEmpty());
        colorsNew.add('Green');
        colorsNew.add('Grey');
        colorsNew.add('Violet');
        System.debug('Colors New is ' +colorsNew);
        colorsNew.remove('Green');
        System.debug('Removed green ' +colorsNew);
        colorsNew.removeAll(new Set<String>{'Aries', 'Pink', 'Red'});
        System.debug('remove all colors new ' +colorsNew);
        colorsNew.add('Indigo');
        colorsNew.add('Orange');
        System.debug(colorsNew);
        System.debug(colorsNew);
        colorsNew.retainAll(new Set<String>{'Orange'});
        System.debug(colorsNew);
    }
}