import 'package:flutter/material.dart';
import 'package:weather_one/Services/Utils.dart';
import 'package:weather_one/Services/WeatherService.dart';
import 'package:weather_one/ViewModels/TodayWeatherViewModel.dart';

class WeatherProvider extends ChangeNotifier {

  TodayWeatherViewModel? todayWeatherViewModel;

  Future<TodayWeatherViewModel> fetchTodayWeather(BuildContext context,var lat, var long) async {

    late TodayWeatherViewModel todayWeatherViewModel;

    try{
      final results =  await WeatherService().fetchTodayWeather(lat, long);
      todayWeatherViewModel = TodayWeatherViewModel(todayWeather: results);
      this.todayWeatherViewModel = todayWeatherViewModel;
      notifyListeners();
    }
    catch(e){
      Utils.displayDialog(context, "An error occured");
    }

    return todayWeatherViewModel;
    
  }

}