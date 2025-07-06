public class FileTransferService {
    public static void transferFilesToAccount(Id opportunityId) {
        try {
            // step 1 get the parent account of the opportunity id
            Opportunity opp = [SELECT Id, AccountId FROM Opportunity WHERE Id = : opportunityId];
            if(opp.AccountId == null) {
                return;
            }
            //step 2 get all content document link related to the opportunity
            List<ContentDocumentLink> oppFileLinks = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = : opportunityId];
            
            if(oppFileLinks.isEmpty()) {
                System.debug('no files found for this opportunity');
                return;
            }
            
            //step 3 create new content document link for the account object
            List<ContentDocumentLink> accFileLinks = new List<ContentDocumentLink>();
            for(ContentDocumentLink link : oppFileLinks) {
                ContentDocumentLink newLink = new ContentDocumentLink();
                newLink.ContentDocumentId = link.ContentDocumentId;
                newLink.LinkedEntityId = opp.AccountId;
                newLink.ShareType = 'V';
                newLink.Visibility = 'AllUsers';
                accFileLinks.add(newLink);
            }
            //step 4 insert accFileLinks to attach the files to the account
            if(!accFileLinks.isEmpty()) {
                insert accFileLinks;
                System.debug('Files successfully transferred');
            }
        } catch(Exception e) {
            System.debug('error transferring file ' + e.getMessage());
        }
    }
}