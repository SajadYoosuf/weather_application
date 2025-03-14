import 'package:flutter/material.dart';
import 'package:weather_application/model/weather_data.dart';
import 'package:weather_application/services/weather_services.dart';
import 'package:weather_application/utilities/images.dart';

class WeatherFunctions extends ChangeNotifier{
  String weatherBackgroundImage='assets/images/weather_background.jpg';
//  static  DateTime? sunrise;
// static   DateTime? sunset;

   
   void backgroundImageChecking(String discription,double currentTemp){
     
    switch (discription) {
      case 'clear sky':
        weatherBackgroundImage= Images.clear;
      case 'few clouds':
        weatherBackgroundImage= Images.cloud;
      case 'scattered clouds':
       weatherBackgroundImage= Images.cloud;
       case 'broken clouds':
       weatherBackgroundImage= Images.cloud;
       case 'shower rain':
       weatherBackgroundImage= Images.rain;
       case 'rain':
       weatherBackgroundImage= Images.rain;
       case 'thunderstorm':
       weatherBackgroundImage= Images.rain;
       case 'snow':
       weatherBackgroundImage= Images.snow;
       case 'mist':
       weatherBackgroundImage= Images.mist;
       
      default:
      weatherBackgroundImage;
    }
    // sunrise=DateTime.fromMillisecondsSinceEpoch((currentSunrise * 1000).toInt());
    // sunset=DateTime.fromMillisecondsSinceEpoch((currentSunset * 1000).toInt());
   }
}