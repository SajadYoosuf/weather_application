import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/model/weather_data.dart';
import 'package:weather_application/services/weather_services.dart';
import 'package:weather_application/utilities/images.dart';
import 'package:weather_application/view%20model/weather_functions.dart';
import 'package:weather_application/view/search_screen.dart';
import 'package:weather_application/widgets/data_display.dart';

class WidgetDataDisplaying extends StatelessWidget {
  const WidgetDataDisplaying({super.key, required this.weatherData});
  final WeatherData weatherData;
  @override
  Widget build(BuildContext context) {
    final function = Provider.of<WeatherFunctions>(context);
    DateTime now = DateTime.now();

    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchPage())),
        child: const Icon(
          Icons.explore,
          size: 40,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: 830,
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
            Text(weatherData!.name,
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
              'https://openweathermap.org/img/wn/${weatherData!.weather[0].icon.toString()}@2x.png',
              width: 200,
              height: 100,
              fit: BoxFit.cover,
            ),
            Text(weatherData!.weather[0].description,
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
                    '${(372 - weatherData!.main.temp).toStringAsFixed(0)}\u00B0C',
                    Images.tempIcon),
                dataContainer(
                    context,
                    'Visiblity',
                    '${(weatherData!.visibility).toStringAsFixed(0)}km',
                    Images.visibilityIcon),
                dataContainer(
                    context,
                    'Wind Speed',
                    '${(weatherData!.wind.speed).toStringAsFixed(0)}kph',
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
                    '${(372 - weatherData!.main.feelsLike).toStringAsFixed(0)}\u00B0C',
                    Images.feelsLike),
                dataContainer(context, 'Air Pressure',
                    '${weatherData!.main.pressure}hpa', Images.perssureIcon),
                dataContainer(context, 'Humidity',
                    '${weatherData!.main.humidity}', Images.humidityIcon),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
