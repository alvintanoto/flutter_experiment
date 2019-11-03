import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_experiment/CurrentWeather.dart';
import 'package:flutter_experiment/Statics.dart';
import 'package:flutter_experiment/WeatherUrl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_experiment/Utils.dart' as Util;

class MainInfoCard extends StatefulWidget {
  MainInfoCard({Key key, this.placemark}) : super(key: key);

  final Placemark placemark;

  @override
  MainInfoCardState createState() => MainInfoCardState();
}

class MainInfoCardState extends State<MainInfoCard> {
  var countryCode;
  var countryName;
  var fullAddress;
  CurrentWeather currentWeather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  Future<http.Response> fetchCurrentWeatherData(lat, lon) async {
    final response = await http.get(WeatherUrl()
        .getWeatherUrlByZipcode(lat, lon, Statics().openWeatherApiKey));
    if (response.statusCode == 200) {
      var dataWeather = new CurrentWeather();
      dataWeather.weatherMain = jsonDecode(response.body)['weather'][0]['main'];
      dataWeather.weatherId = jsonDecode(response.body)['weather'][0]['id'];
      dataWeather.weatherIcon = jsonDecode(response.body)['weather'][0]['icon'];
      dataWeather.tempNow = jsonDecode(response.body)['main']['temp'];
      dataWeather.tempMin = jsonDecode(response.body)['main']['temp_min'];
      dataWeather.tempMax = jsonDecode(response.body)['main']['temp_max'];
      setState(() {
        currentWeather = dataWeather;
      });
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  void setData() {
    if (widget.placemark != null) {
      countryCode = widget.placemark.isoCountryCode;
      countryName = widget.placemark.country;

      fullAddress =
      "${widget.placemark.thoroughfare} No. ${widget.placemark
          .subThoroughfare}\n"
          "${widget.placemark.locality}, ${widget.placemark.subLocality}\n"
          "${widget.placemark.administrativeArea}, ${widget.placemark
          .subAdministrativeArea}\n"
          "${widget.placemark.postalCode}";
      fetchCurrentWeatherData(widget.placemark.position.latitude,
          widget.placemark.position.longitude);
    }
  }

  Widget currentWeatherWidget() {
    if (currentWeather == null) {
      return Container();
    } else {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      WeatherUrl().getIcon(currentWeather.weatherIcon),
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Text(
                            currentWeather.weatherMain,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ))
                  ],
                )),
            Container(
              height: 100,
              margin: EdgeInsets.only(left: 12, right: 12),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                Util.convertFarenheitToCelcius(
                                    currentWeather.tempMin),
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "MIN",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Util.convertFarenheitToCelcius(
                                      currentWeather.tempMax),
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "CURRENT",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            )
                          ],
                        ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                Util.convertFarenheitToCelcius(
                                    currentWeather.tempMax),
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "MAX",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Color(0xFFFBE9E7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
      child: Container(
        width: double.infinity,
        height: 350,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 48,
              margin: EdgeInsets.only(top: 12, right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 36,
                    width: 48,
                    margin: EdgeInsets.only(left: 35),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://www.countryflags.io/${countryCode}/flat/64.png"),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Text(
                      countryName,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Text(
                fullAddress,
                style: TextStyle(fontSize: 14),
              ),
            ),
            currentWeatherWidget(),
          ],
        ),
      ),
    );
  }
}
