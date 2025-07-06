public class HandleAccountLWC {
    @AuraEnabled(cacheable=true)
        public static List<Contact> FetchContact(){
            List <Contact> conlist =[SELECT Id,Name,Phone,Email,MailingAddress FROM Contact WHERE FirstName='Sanjay'];
         return conlist;
        }
       
    }