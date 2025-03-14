import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_application/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_application/view%20model/current_location.dart';

class WeatherServices extends ChangeNotifier{
  
     CurrentLocation location =CurrentLocation();
  Future<WeatherData> fechWeather(BuildContext context,bool currentOrSearch,String location)async{
    double? latitude;
    double? longitude;
if(currentOrSearch){
 await CurrentLocation.getCurrentPosition(context);
    latitude=CurrentLocation.currentPosition!.latitude;
    longitude=CurrentLocation.currentPosition!.longitude;
  //     print(CurrentLocation.currentPosition!.latitude);
  //  print(CurrentLocation.currentPosition!.longitude);
}else{
 CurrentLocation.getCoordinates(context,location);
  latitude=CurrentLocation.locations!.first.latitude;
  longitude=CurrentLocation.locations!.first.longitude;
 
}
  
  
 

   try{
 final response = await http.get(
    Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=0b7ba5fee847e15d1384009514fc2e21'),
  );
  // print(location);
  // print(CurrentLocation.locations!.first.latitude);
  // print(CurrentLocation.locations!.first.longitude);
  // print(response.statusCode);

  if (response.statusCode == 200) {
  
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return WeatherData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
   }catch (parseError){
     throw Exception('Failed to load User Data: $parseError');
   }
    
  }
}