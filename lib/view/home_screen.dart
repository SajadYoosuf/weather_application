import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/model/weather_data.dart';
import 'package:weather_application/services/weather_services.dart';
import 'package:weather_application/utilities/constant.dart';
import 'package:weather_application/utilities/images.dart';
import 'package:weather_application/view%20model/weather_functions.dart';
import 'package:weather_application/view/search_screen.dart';
import 'package:weather_application/view/widget_data_displaying.dart';
import 'package:weather_application/widgets/data_display.dart';
import 'package:weather_application/widgets/weather_data_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherFunctions>(context, listen: false)
          .fetchWeatherData(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Scaffold(body: Consumer<WeatherFunctions>(
      builder: (context, function, child) {
        if (function.status == NetworkStatus.loaded) {
          return WidgetDataDisplaying(
            weatherData: function.weatherData,
          );
        } else if (function.status == NetworkStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (function.status == NetworkStatus.error) {
          return const Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
              size: 30,
            ),
          );
        }
        return SizedBox();
      },
    ));
  }
}
