import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  late Position userLocation;

  Future<bool> getLocation(BuildContext context) async {

    bool serviceEnabled;
    LocationPermission permission;
    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return false; 
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return false;
      }
    }

    userLocation = await Geolocator.getCurrentPosition();
    emit(LocationLoaded(userLocation: userLocation));
    return true;
    
  }
}
