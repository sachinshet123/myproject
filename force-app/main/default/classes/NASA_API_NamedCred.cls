public class NASA_API_NamedCred {
 public static void getAstronomyPictureOfTheDay() {
        String namedCredentialUrl = 'callout:NASA_API_Credential/planetary/apod';
        String apiKey = 'YbbMNWeWX2BqxoPKXEiWWcKMgNlUHhHXgqWG5XBt';  // Replace with your NASA API key
        String requestUrl = namedCredentialUrl + '?api_key=' + apiKey;
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