public class NASA_API_Example {
public static void getAstronomyPictureOfTheDay() {
        	String apiEndpoint = 'https://api.nasa.gov/planetary/apod';
String apiKey = '37d1gxwQRsH9UyPTcU2bmMqs092132dNNaLdP31k';   //Paste the API Key you get in Email
     	   	String requestUrl = apiEndpoint + '?api_key=' + apiKey;
  
        	HttpRequest req = new HttpRequest();
        	req.setEndpoint(requestUrl);
       	req.setMethod('GET');
        	Http http = new Http();
       	 HttpResponse res = http.send(req);

        	if (res.getStatusCode() == 200) {
           	String jsonResponse = res.getBody();
          String jsonResponseFinal = jsonResponse.replaceAll('"date":', '"dateparam":');

Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(jsonResponseFinal);
String url = (String) responseMap.get('url');
            	 String title = (String) responseMap.get('title');
           	 String explanation = (String) responseMap.get('explanation');
           	 String hdUrl = (String) responseMap.get('hdurl');
           	 String dateparam = (String) responseMap.get('dateparam');
           	 String copyright = (String) responseMap.get('copyright');
            
                    System.debug('Astronomy Picture URL: ' + url);
          	 System.debug('Title: ' + title);
          	  System.debug('Explanation: ' + explanation);
           	 System.debug('HD URL: ' + hdUrl);
           	 System.debug('Date: ' + dateparam);
            	System.debug('Copyright: ' + copyright);
        } else {
                 System.debug('Error: ' + res.getStatusCode() + ' ' + res.getStatus());
        }
    }
}