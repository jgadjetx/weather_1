import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_one/Services/Utils.dart';

class LocationProvider extends ChangeNotifier {

  late Position userLocation;

  Future<bool> getLocation(BuildContext context) async {

    bool serviceEnabled;
    LocationPermission permission;
    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.displayDialog(context, 'Location services are disabled.');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      Utils.displayDialog(context, 'Location permissions are permantly denied, Please enabled location services');
      return false; 
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        Utils.displayDialog(context, 'Location permissions are denied');
        return false;
      }
    }

    userLocation = await Geolocator.getCurrentPosition();
    notifyListeners();
    return true;
    
  }

}