class WeatherUrl {
  String getWeatherUrlByZipcode(lat, lon, apiKey){
    return "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey";
  }
  String getIcon(code){
    return "http://openweathermap.org/img/wn/$code@2x.png";
  }
}