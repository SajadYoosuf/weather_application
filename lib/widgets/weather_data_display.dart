import 'package:flutter/material.dart';
import 'package:weather_application/utilities/images.dart';
import 'package:weather_application/view%20model/weather_functions.dart';
import 'package:weather_application/widgets/data_display.dart';

Widget buildWeatherDataDisplay(
    BuildContext context, WeatherFunctions function) {
  DateTime now = DateTime.now();

  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(function.weatherBackgroundImage),
            fit: BoxFit.fill)),
    child: Column(
      children: [
        // Row(crossAxisAlignment:CrossAxisAlignment.center,children: [IconButton(onPressed:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage())), icon: Icon(Icons.explore))],),
        const SizedBox(
          height: 100,
        ),
        Text(function.weatherData!.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white)),
        Text('${now.day}.${now.month}.${now.year}',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white)),
        Image.network(
          'https://openweathermap.org/img/wn/${function.weatherData!.weather[0].icon.toString()}@2x.png',
          width: 200,
          height: 100,
          fit: BoxFit.cover,
        ),
        Text(function.weatherData!.weather[0].description,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white)),
        const SizedBox(
          height: 50,
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            dataContainer(
                context,
                'Temp',
                '${(372 - function.weatherData!.main.temp).toStringAsFixed(0)}\u00B0C',
                Images.tempIcon),
            dataContainer(
                context,
                'Visiblity',
                '${(function.weatherData!.visibility).toStringAsFixed(0)}km',
                Images.visibilityIcon),
            dataContainer(
                context,
                'Wind Speed',
                '${(function.weatherData!.wind.speed).toStringAsFixed(0)}kph',
                Images.tempIcon),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            dataContainer(
                context,
                'Feels Like',
                '${(372 - function.weatherData!.main.feelsLike).toStringAsFixed(0)}\u00B0C',
                Images.feelsLike),
            dataContainer(
                context,
                'Air Pressure',
                '${function.weatherData!.main.pressure}hpa',
                Images.perssureIcon),
            dataContainer(context, 'Humidity',
                '${function.weatherData!.main.humidity}', Images.humidityIcon),
          ],
        ),
      ],
    ),
  );
}
