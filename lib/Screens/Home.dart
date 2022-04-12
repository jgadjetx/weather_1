import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_one/Providers/LocationProvider.dart';
import 'package:weather_one/Providers/WeatherProvider.dart';
import 'package:weather_one/ViewModels/TodayWeatherViewModel.dart';
import 'package:weather_one/Widgets/TodayWeatherWidget.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late WeatherProvider weatherProvider;
  late LocationProvider locationProvider;
  bool gotUserLocation = false;

  var lattitude;
  var longitude;

  void getUserLocation(){

    locationProvider.getLocation(context).then((value){

      gotUserLocation = value;

      if(gotUserLocation){

        lattitude = locationProvider.userLocation.latitude.toString();
        longitude = locationProvider.userLocation.longitude.toString();

        weatherProvider.fetchTodayWeather(context, lattitude, longitude);
      }

    });

  }

  @override
  void initState() {
    super.initState();

    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
     
    getUserLocation();

  }

  @override
  Widget build(BuildContext context) {
    
    weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            weatherProvider.todayWeatherViewModel != null ?
            Expanded(
              flex: 2,
              child: TodayWeatherWidget(todayWeatherViewModel:weatherProvider.todayWeatherViewModel)
            ): 
            Expanded(
              flex: 1,
              child: Center(
                child: Text("Loading...")
              )
            ),

            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Container(
                  height: 1.5,
                  width: 150.0,
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 25.0),
                ),
              ),
            ),

            Expanded(
              flex: 6,
              child: Text("Hello", style: TextStyle(color: Colors.white))
            )
          ],
        ),
      )
    );
  }
}