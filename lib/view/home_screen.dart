import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/model/weather_data.dart';
import 'package:weather_application/services/weather_services.dart';
import 'package:weather_application/utilities/images.dart';
import 'package:weather_application/view%20model/weather_functions.dart';
import 'package:weather_application/view/search_screen.dart';
import 'package:weather_application/widgets/data_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<WeatherData>? future;
  @override
  void initState() {

 WidgetsBinding.instance.addPostFrameCallback((_) {
      future=context.read<WeatherServices>().fechWeather(context,true,'');

});
    
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
floatingActionButton:FloatingActionButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage())),child: Icon(Icons.explore,size: 40,color: Colors.white,),backgroundColor: Colors.black,),
      body: Consumer<WeatherFunctions>(
          builder: (context,function,child) {
          return  FutureBuilder<WeatherData>(
                future: future,
                builder: (context, snapshot) {

                 if (snapshot.hasData) {
                  print("ijgwiogjoiwigj");
    function.backgroundImageChecking(snapshot.data!.weather[0].description, snapshot.data!.main.temp);

                    return Container(
                      height: 830,
                      width: MediaQuery.of(context).size.width,
decoration: BoxDecoration(image: DecorationImage(image: AssetImage(function.weatherBackgroundImage),fit: BoxFit.fill)),
                      child: Column(
                        children: [
                          // Row(crossAxisAlignment:CrossAxisAlignment.center,children: [IconButton(onPressed:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage())), icon: Icon(Icons.explore))],),
                          SizedBox(height: 100,),
                          Text(snapshot.data!.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white)),
                          Text('${now.day}.${now.month}.${now.year}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white)),
                          Image.network(
                            'https://openweathermap.org/img/wn/${snapshot.data!.weather[0].icon.toString()}@2x.png',
                            width: 200,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Text(snapshot.data!.weather[0].description,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white)),
          SizedBox(height: 50,),    Divider(),       Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dataContainer(context,'Temp','${(372-snapshot.data!.main.temp).toStringAsFixed(0)}\u00B0C',Images.tempIcon),
                             dataContainer(context, 'Visiblity', '${(snapshot.data!.visibility).toStringAsFixed(0)}km',Images.visibilityIcon),
                             dataContainer(context,'Wind Speed','${(snapshot.data!.wind.speed).toStringAsFixed(0)}kph',Images.tempIcon),
                             
                            ],
                          ),
                          Divider(),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                            dataContainer(context, 'Feels Like','${(372-snapshot.data!.main.feelsLike).toStringAsFixed(0)}\u00B0C' ,Images.feelsLike),
                            dataContainer(context, 'Air Pressure', '${snapshot.data!.main.pressure}hpa',Images.perssureIcon),
                            dataContainer(context, 'Humidity', '${snapshot.data!.main.humidity}',Images.humidityIcon),
                          ],),
                         
                        ],
                      ),
                    );
                  } else {
                    print(snapshot.error);
                    return const Center(child: CircularProgressIndicator());
                  }
                },
            );
          } ));
    
  }
}
