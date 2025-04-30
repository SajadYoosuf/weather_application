import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/services/weather_services.dart';
import 'package:weather_application/utilities/district_names.dart';
import 'package:weather_application/utilities/images.dart';
import 'package:weather_application/view%20model/location_details.dart';
import 'package:weather_application/view%20model/weather_functions.dart';
import 'package:weather_application/view/home_screen.dart';
import 'package:weather_application/view/widget_data_displaying.dart';
import 'package:weather_application/widgets/weather_data_display.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final DateTime now = DateTime.now();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherFunctions>(context, listen: false)
          .fetchAllDistrictsWeather(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherFunctions>(context);
    final function = Provider.of<LocationDetails>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage())),
          child: const Icon(
            Icons.home,
            size: 40,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.cloud), fit: BoxFit.fill)),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22)),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.80,
                child: TextField(
                  controller: function.controller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () => provider
                          .fetchWeatherDataBySearch(
                              context, function.controller.text)
                          .then((onValue) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WidgetDataDisplaying(
                                    weatherData: onValue)));
                      }),
                      tooltip: 'press this icon for searching',
                    ),
                    border: const OutlineInputBorder(),
                    hintText: '         search your place',
                  ),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.87,
                  width: 300,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final district = disctricts[index];
                        final weatherData =
                            provider.districtWeatherMap[district];

                        if (weatherData == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WidgetDataDisplaying(
                                        weatherData: weatherData,
                                      ))),
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(22)),
                            height: 150,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 40),
                                        Text(
                                          district,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Image.network(
                                          'https://openweathermap.org/img/wn/${weatherData.weather[0].icon.toString()}@2x.png',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                            '${(weatherData.main.temp - 273.15).toStringAsFixed(0)}\u00B0C'),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: 14))
            ],
          ),
        ));
  }
}
