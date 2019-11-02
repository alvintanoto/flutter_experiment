class CurrentWeather {
  var weatherId;
  var weatherMain;
  var weatherIcon;
  var tempNow;
  var tempMin;
  var tempMax;

  CurrentWeather({this.weatherId, this.weatherMain, this.weatherIcon, this.tempNow, this.tempMin, this.tempMax});

  String getWeatherIcon(){
    return weatherIcon;
  }
}