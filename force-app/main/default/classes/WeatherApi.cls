public class WeatherApi {

    public static void getWeatherDetails(String city){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndPoint('callout:WeatherAPI/current.json??key=650d1add5dec4152944111338251802&q='+ city);
        HttpResponse res = http.send(req);
        System.debug(res.getBody());
        system.debug(res.getStatus());
        system.debug(res.getStatusCode());
        if(res.getStatusCode()==200){

            WeatherApiResponse instance = WeatherApiResponse.parse(res.getBody());

            System.debug('temp_c ' +instance.Current.temp_c);

            System.debug('cloud ' +instance.Current.cloud);

        }
        
    }
}