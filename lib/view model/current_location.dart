import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_application/model/weather_data.dart';
import 'package:weather_application/services/weather_services.dart';

class CurrentLocation extends ChangeNotifier{
    String? currentAddress;
static  Position? currentPosition;
static List<Location>? locations;
TextEditingController controller=TextEditingController();
 static Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;
  
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {   
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}
   static Future<void> getCurrentPosition(BuildContext context) async {
    final hasPermission = await handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
     currentPosition = position;
    }).catchError((e) {
      debugPrint(e);
    });
  }
static Future<List<Location>?> getCoordinates(BuildContext context,String location) async {
  
  try {
     locations= await locationFromAddress(location + ", Kerala, India");
    if (locations!.isNotEmpty) {
            // print('$location: ${locations!.first.latitude}, ${locations!.first.longitude}');

  return locations;

    }
  } catch (e) {
    
    print('Error fetching location for $location: $e');
  }
  return null;
}
}