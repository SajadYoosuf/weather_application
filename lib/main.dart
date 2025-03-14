import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/services/weather_services.dart';
import 'package:weather_application/view%20model/current_location.dart';
import 'package:weather_application/view%20model/navigation.dart';
import 'package:weather_application/view%20model/weather_functions.dart';
import 'package:weather_application/view/home_screen.dart';

void main() {
  runApp(MultiProvider(providers:[ChangeNotifierProvider<Navigation>(create: (_)=>Navigation()),ChangeNotifierProvider<WeatherServices>(create: (_)=>WeatherServices()),ChangeNotifierProvider<WeatherFunctions>(create: (_)=>WeatherFunctions()),ChangeNotifierProvider<CurrentLocation>(create: (_)=>CurrentLocation())],child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage()
    );
  }
}
