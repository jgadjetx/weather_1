import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_one/Models/DailyWeather.dart';
import 'package:weather_one/Services/WeatherService.dart';

part 'weeksweather_state.dart';

class WeeksweatherCubit extends Cubit<WeeksweatherState> {

  WeeksweatherCubit() : super(WeeksweatherInitial());

  Future<bool> fetchFiveDayForecastWeather(lattitude, longitude) async{

    bool gotFiveDayWeather = false;
    List<DailyWeather> fiveDayWeather;

    await WeatherService().fetchFiveDayForecastWeather(lattitude, longitude).then((results){

      fiveDayWeather = results;
      gotFiveDayWeather = true;
      emit(WeeksweatherLoaded(fiveDayWeather: fiveDayWeather));
    });

    return gotFiveDayWeather;
  }

  updateWeeklyLiveLocationWeather(var lat, var long)  async{
    
    List<DailyWeather> fiveDayWeather;
    bool gotFiveDayWeather = false;
    
    await WeatherService().fetchFiveDayForecastWeather(lat,long).then((results){

      fiveDayWeather = results;
      gotFiveDayWeather = true;
      emit(WeeksweatherLive(fiveDayWeatherLive: fiveDayWeather));
      
    });

    return gotFiveDayWeather;
  }

}
