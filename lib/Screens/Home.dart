import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_one/Models/DailyWeather.dart';
import 'package:weather_one/Models/TodayWeather.dart';
import 'package:weather_one/Services/Utils.dart';
import 'package:weather_one/Widgets/DailyWeatherListWidget.dart';
import 'package:weather_one/Widgets/FailedToGetLocationWidget.dart';
import 'package:weather_one/Widgets/LoadingWidget.dart';
import 'package:weather_one/Widgets/HorizontalWhiteLine.dart';
import 'package:weather_one/Widgets/ShimmerBlock.dart';
import 'package:weather_one/Widgets/TodayWeatherWidget.dart';
import 'package:weather_one/cubit/location_cubit.dart';
import 'package:weather_one/cubit/todayweather_cubit.dart';
import 'package:weather_one/cubit/weeksweather_cubit.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var lattitude;
  var longitude;

  late LocationCubit locatoinCubit;
  late TodayweatherCubit todayweatherCubit;
  late WeeksweatherCubit weeksweatherCubit;

  void getUserLocation() async{

    await locatoinCubit.getLocation(context).then((gotUserLocation) async{

      if(gotUserLocation){

        lattitude = locatoinCubit.userLocation.latitude.toString();
        longitude = locatoinCubit.userLocation.longitude.toString();

        try{
          await todayweatherCubit.fetchTodayWeather(lattitude, longitude);
          await weeksweatherCubit.fetchFiveDayForecastWeather(lattitude, longitude);
        }
        catch(e){
          Utils.displayDialog(context, "An error occured, Please try again later");
        }
        
      }
      else{
        Geolocator.openLocationSettings();
      }

    });

  }

  @override
  void initState() {
    super.initState();
    
    locatoinCubit = BlocProvider.of<LocationCubit>(context);
    todayweatherCubit = BlocProvider.of<TodayweatherCubit>(context);
    weeksweatherCubit = BlocProvider.of<WeeksweatherCubit>(context);
    getUserLocation();

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, locationState) {

            if(locationState is LocationInitial){

              return LoadingWidget(message: 'Getting your location...');

            }
            else if(locationState is LocationLoaded){

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //today weather
                  Expanded(
                    flex: 2, 
                    child: BlocBuilder<TodayweatherCubit, TodayweatherState>(
                      builder: (context, todayWeatherState) {
                  
                        if(todayWeatherState is TodayweatherInitial){
                  
                          return LoadingWidget(message:"Getting today's weather...");

                        }
                        else if(todayWeatherState is TodayWeatherLoaded){
                          
                          TodayWeather todayWeather = todayWeatherState.todayWeather;
                          return TodayWeatherWidget(todayWeather: todayWeather);
                                
                        }
                  
                        return Container();
                      }
                    ),
                  ),

                  
                  HorizontalWhiteLine(),

                  //weeks weather
                  Expanded(
                    flex: 6, 
                    child: BlocBuilder<WeeksweatherCubit, WeeksweatherState>(
                      builder: (context, weeksWeatherState) {
                  
                        if(weeksWeatherState is WeeksweatherInitial){
                  
                         return SingleChildScrollView(
                           child: Column(
                              children: [
                                ShimmerBlock(),
                                ShimmerBlock(),
                                ShimmerBlock()
                              ],
                            ),
                         );
                        }
                        else if(weeksWeatherState is WeeksweatherLoaded){
                           
                          List<DailyWeather> weeklyWeatherState = weeksWeatherState.fiveDayWeather;
                          return DailyWeatherListWidget(dailyWeather: weeklyWeatherState);                               
                        }
                  
                        return Container();
                      }
                    ),
                  ),

                ],
              );
            }     
            else if(locationState is LocationFailed){

              return FaliedToGetLocationWidget(onPressed: getUserLocation);
            }

            return Container();
          }
        )       
      )
    );
  }
}