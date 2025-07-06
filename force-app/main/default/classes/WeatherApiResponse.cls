public class WeatherApiResponse{
		public location location{get;set;}
		public current current{get;set;}
	public class location{
		public String tz_id{get;set;}
		public Decimal lon{get;set;}
		public Integer localtime_epoch{get;set;}
		public Decimal lat{get;set;}
		public String localtime{get;set;}
		public String country{get;set;}
		public String region{get;set;}
		public String name{get;set;}
	}
	public class current{
		public String wind_dir{get;set;}
		public Decimal precip_in{get;set;}
		public Integer humidity{get;set;}
		public Decimal precip_mm{get;set;}
		public Integer cloud{get;set;}
		public Decimal pressure_in{get;set;}
		public Decimal feelslike_c{get;set;}
		public Decimal pressure_mb{get;set;}
		public Decimal feelslike_f{get;set;}
		public Integer wind_degree{get;set;}
		public Decimal windchill_c{get;set;}
		public Decimal wind_kph{get;set;}
		public Decimal windchill_f{get;set;}
		public Decimal wind_mph{get;set;}
		public Decimal heatindex_c{get;set;}
		public condition condition{get;set;}
		public Decimal heatindex_f{get;set;}
		public Decimal dewpoint_f{get;set;}
		public Decimal dewpoint_c{get;set;}
		public Decimal vis_km{get;set;}
		public Integer is_day{get;set;}
		public Decimal vis_miles{get;set;}
		public Decimal temp_f{get;set;}
		public Decimal uv{get;set;}
		public Decimal temp_c{get;set;}
		public Decimal gust_mph{get;set;}
		public String last_updated{get;set;}
		public Decimal gust_kph{get;set;}
		public Integer last_updated_epoch{get;set;}
	}
	public class condition{
		public Integer code{get;set;}
		public String icon{get;set;}
		public String text{get;set;}
	}
    public static WeatherApiResponse parse(String json) {
		return (WeatherApiResponse) System.JSON.deserialize(json, WeatherApiResponse.class);
	}

}