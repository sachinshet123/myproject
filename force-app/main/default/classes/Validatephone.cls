public class Validatephone {
        public static void afterInsertphone(List<Contact> conList){
            Map<Id,String> conPhoneMap = new Map<Id,String>();
            for(Contact con : conList){
               If(String.isNotEmpty(con.Phone)){
                    conPhoneMap.put(con.Id,con.Phone);
               }
            }
            if(!conPhoneMap.isEmpty()){
                performNumverifyOp(conPhoneMap);
            }
        }
        @future(callout=true)
        public static void performNumverifyOp(Map<Id,String> contactphoneMap){
            Map<Id,Boolean> conPhoneResponse = new Map<Id,Boolean>();
            for(Id conId : contactphoneMap.keySet()){
                String phoneNum = contactphoneMap.get(conId);
                //get custom label by passing you customlabel name (eg : API_Key) it is used in endpoint creation 
                String getCustomLabel = System.Label.num_api_key;
                //now create end point copy the sample from Docs of API (http://apilayer.net/api/validate?access_ke=4c627b*****3b01a82e671ce072451157f1&number = 14158586273)
                String endpoint = 'http://apilayer.net/api/validate?access_key=' + getCustomLabel + '&number=' + phoneNum + '&country_code=IN&format=1' ; 
                    Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setmethod('GET');
                request.setEndpoint(endpoint);
                request.setHeader('Content-Type', 'application/json');
                request.setTimeout(12000);
                
                //invoke the request
                HttpResponse response = http.send(request);
                System.debug(response.getStatus());
                System.debug(response.getStatusCode());
                System.debug(response.getBody());
                if(response.getStatusCode()==200){
                    String responseBody = response.getBody();
                    NewJSon2Apex formattedResponse = NewJSon2Apex.parse(responseBody);
                    conPhoneResponse.put(conId,formattedResponse.valid);
                }
                
            }
             List<Contact> conlistfetch =[SELECT Id, validate_phone_number__c FROM Contact WHERE Id in:conPhoneResponse.keySet()];
    
            for(Contact con : conlistfetch){
    
                con.validate_phone_number__c = conPhoneResponse.get(con.Id);
    
            }
    
            if(!conlistfetch.isEmpty()){
    
                try{
    
                update conlistfetch;
    
                }
    
                catch(Exception e){
    
                    system.debug(e.getMessage());
                }
            }
        }
    }