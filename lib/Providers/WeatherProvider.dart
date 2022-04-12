import 'package:flutter/material.dart';
import 'package:weather_one/Services/WeatherService.dart';
import 'package:weather_one/ViewModels/DailyWeatherViewModel.dart';
import 'package:weather_one/ViewModels/TodayWeatherViewModel.dart';

class WeatherProvider extends ChangeNotifier {

  TodayWeatherViewModel? todayWeatherViewModel;
  List<DailyWeatherViewModel>? dailyWeatherViewModel;

  Future<TodayWeatherViewModel> fetchTodayWeather(var lat, var long) async {

    late TodayWeatherViewModel todayWeatherViewModel;

    try{
      final results =  await WeatherService().fetchTodayWeather(lat, long);
      todayWeatherViewModel = TodayWeatherViewModel(todayWeather: results);
      this.todayWeatherViewModel = todayWeatherViewModel;
      notifyListeners();
    }
    catch(e){
      throw Exception("Unable to perform request!");
    }

    return todayWeatherViewModel;
    
  }

  Future<List<DailyWeatherViewModel>> fetchFiveDayForecastWeather(var lat, var long) async {

    late  List<DailyWeatherViewModel> dailyWeatherViewModel;

    try{
      final results =  await WeatherService().fetchFiveDayForecastWeather(lat, long);
      dailyWeatherViewModel = results.map((item) => DailyWeatherViewModel(dailyWeather: item)).toList();
      this.dailyWeatherViewModel = dailyWeatherViewModel;
      notifyListeners();
    }
    catch(e){
      throw Exception("Unable to perform request!");
    }

    return dailyWeatherViewModel;
    
  }

}