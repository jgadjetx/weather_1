import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_one/Providers/LocationProvider.dart';
import 'package:weather_one/Providers/WeatherProvider.dart';
import 'package:weather_one/Services/Utils.dart';
import 'package:weather_one/Widgets/DailyWeatherListWidget.dart';
import 'package:weather_one/Widgets/ShimmerBlock.dart';
import 'package:weather_one/Widgets/TodayWeatherWidget.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late WeatherProvider weatherProvider;
  late LocationProvider locationProvider;

  var lattitude;
  var longitude;

  void getUserLocation() async{

    await locationProvider.getLocation(context).then((gotUserLocation) async{

      if(gotUserLocation){

        lattitude = locationProvider.userLocation.latitude.toString();
        longitude = locationProvider.userLocation.longitude.toString();

        try{
          await weatherProvider.fetchTodayWeather(lattitude, longitude);
          await weatherProvider.fetchFiveDayForecastWeather(lattitude, longitude);
        }
        catch(e){
          Utils.displayDialog(context, "An error occured, Please try again later");
        }
        
      }
      else{
        
        Utils.customDisplayDialog(context, "An error occured while getting your location, Please enable your location services", "Enable",() async{
          Navigator.of(context).pop();
          Geolocator.openLocationSettings().then((value){
            getUserLocation();
          });
         
        });
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
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              flex: 2,
              child: Consumer<WeatherProvider>(
                builder: (context,weatherProvider,child ){

                  if(weatherProvider.todayWeatherViewModel != null) {
                    return TodayWeatherWidget(todayWeatherViewModel:weatherProvider.todayWeatherViewModel);
                  }
                  else{ 
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: 60,
                        width: 60,
                        child: Image.asset("images/cloud.png"),
                      ),  
                    );
                  }
                  
                }
              ),
            ),

            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Container(
                  height: 1.5,
                  width: 150.0,
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 15.0),
                ),
              ),
            ),

            Expanded(
              flex: 6,
              child: Consumer<WeatherProvider>(
                builder: (context,weatherProvider,child ){

                  if(weatherProvider.dailyWeatherViewModel != null) {
                    return DailyWeatherListWidget(dailyWeatherViewModel: weatherProvider.dailyWeatherViewModel);
                  }
                  else{ 
                    return Column(
                      children: [
                        ShimmerBlock(),
                        ShimmerBlock(),
                        ShimmerBlock()
                      ],
                    );
                  }
                  
                }
              ),
            ),

          ],
        ),
      )
    );
  }
}