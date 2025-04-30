import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_application/model/weather_data.dart';
import 'package:weather_application/services/weather_services.dart';
import 'package:weather_application/utilities/constant.dart';
import 'package:weather_application/utilities/district_names.dart';
import 'package:weather_application/utilities/images.dart';
import 'package:weather_application/view%20model/location_details.dart';
import 'package:weather_application/view/home_screen.dart';
import 'package:weather_application/view/search_screen.dart';

class WeatherFunctions extends ChangeNotifier {
  String weatherBackgroundImage = 'assets/images/weather_background.jpg';
  double? latitude;
  double? longitude;
  var weatherData;
  Map<String, WeatherData?> districtWeatherMap = {};

  // ignore: prefer_final_fields
  NetworkStatus _status = NetworkStatus.loading;
  NetworkStatus get status => _status;
  int currentPageIndex = 0;
  List<Widget> pageList = [const HomePage(), SearchPage()];
  void changeNav(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

  void backgroundImageChecking(String discription, double currentTemp) {
    switch (discription) {
      case 'clear sky':
        weatherBackgroundImage = Images.clear;
      case 'few clouds':
        weatherBackgroundImage = Images.cloud;
      case 'scattered clouds':
        weatherBackgroundImage = Images.cloud;
      case 'broken clouds':
        weatherBackgroundImage = Images.cloud;
      case 'shower rain':
        weatherBackgroundImage = Images.rain;
      case 'rain':
        weatherBackgroundImage = Images.rain;
      case 'thunderstorm':
        weatherBackgroundImage = Images.rain;
      case 'snow':
        weatherBackgroundImage = Images.snow;
      case 'mist':
        weatherBackgroundImage = Images.mist;

      default:
        weatherBackgroundImage;
    }
  }

  Future<WeatherData?> fetchWeatherData(BuildContext context) async {
    _status = NetworkStatus.loading;

    await LocationDetails.getCurrentPosition(context);
    latitude = LocationDetails.currentPosition!.latitude;
    longitude = LocationDetails.currentPosition!.longitude;
    print(latitude);
    print(longitude);
    try {
      weatherData = await WeatherServices.fechWeather(latitude!, longitude!);
    } catch (e) {
      print('is something');

      _status = NetworkStatus.error;
    }
    // ignore: unnecessary_null_comparison
    if (weatherData != null) {
      backgroundImageChecking(
          weatherData!.weather[0].description, weatherData!.main.temp);
      print('is loded');
      _status = NetworkStatus.loaded;
    } else {
      print('is error');

      _status = NetworkStatus.error;
    }
    notifyListeners();
    return weatherData;
  }

  Future<void> fetchAllDistrictsWeather(BuildContext context) async {
    for (String district in disctricts) {
      final data = await fetchWeatherDataBySearch(context, district);
      districtWeatherMap[district] = data;
    }
    notifyListeners();
  }

  Future<WeatherData> fetchWeatherDataBySearch(
      BuildContext context, String location) async {
    await LocationDetails.getCoordinates(context, location).then((onValue) {
      latitude = onValue!.first.latitude;
      longitude = onValue!.first.longitude;
    });

    var weatherData;
    _status = NetworkStatus.loading;
    try {
      print(latitude);
      print(longitude);
      weatherData = await WeatherServices.fechWeather(latitude!, longitude!);
    } catch (e) {
      _status = NetworkStatus.error;
    }
    if (weatherData != null) {
      _status = NetworkStatus.loaded;
    } else {
      _status = NetworkStatus.error;
    }
    notifyListeners();
    return weatherData;
  }
}
