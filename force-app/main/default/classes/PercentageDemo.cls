public class PercentageDemo {
    public void Division(Integer marks1, Integer marks2, Integer marks3) {
        Integer totalmarks = marks1+marks2+marks3;
        Integer percentage = totalmarks/3;
        if(percentage>=60) {
            System.debug('first division');
        }
        else if(percentage>=48){
            System.debug('second division');
        }
        else {
            System.debug('third division');
        }
        
    }
}