part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoaded extends LocationState{

  final Position userLocation;

  LocationLoaded({required this.userLocation});

  double getLattitude(){
    return userLocation.latitude;
  }

  double getLongitude(){
    return userLocation.longitude;
  }
}
