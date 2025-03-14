import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/services/weather_services.dart';
import 'package:weather_application/utilities/district_names.dart';
import 'package:weather_application/utilities/images.dart';
import 'package:weather_application/view%20model/current_location.dart';
import 'package:weather_application/view/home_screen.dart';

class SearchPage extends StatelessWidget {
   SearchPage({super.key});
  final  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherServices>(context);
    final function=Provider.of<CurrentLocation>(context);
    return Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage())),
          child: Icon(
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
              SizedBox(
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
                      icon: Icon(Icons.search),
                      onPressed: () => provider.fechWeather(
                          context, false,function.controller.text),
                      tooltip: 'press this icon for searching',
                    ),
                    border: const OutlineInputBorder(),
                    hintText: '         search your place',
                  ),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height*0.87,
                  width: 300,
                  child: ListView.separated(
                      itemBuilder: (context, index) => FutureBuilder(
                          future: provider.fechWeather(
                              context, false,disctricts[index]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                
                                width: 200,
                                decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.circular(22)),
                                height: 150,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(height: 40,),
                                            Text(
                                              disctricts[index],
                                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                                            ),
                                                                                                    
                                          ],
                                        ),
                                          Column(
                                            children: [
                                              Image.network(
                                                                    'https://openweathermap.org/img/wn/${snapshot.data!.weather[0].icon.toString()}@2x.png',
                                                                    width: 100,
                                                                    height: 100,
                                                                    fit: BoxFit.cover,
                                                                  ),  
                                              Text('${(372-snapshot.data!.main.temp).toStringAsFixed(0)}\u00B0C'),
                                            ],
                                          )
                                      ],
                                    ),

                                 ],
                                ),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: 14))
            ],
          ),
        ));
  }
}
