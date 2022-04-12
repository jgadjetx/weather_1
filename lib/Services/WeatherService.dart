import 'dart:convert';

import 'package:weather_one/Models/TodayWeather.dart';
import 'package:weather_one/keys.dart';
import 'package:http/http.dart' as http; 

class WeatherService{

  Future<TodayWeather> fetchTodayWeather(var lat, var long) async{
    
    String url = "www.community-open-weather-map.p.rapidapi.com";
    String headerHost = "community-open-weather-map.p.rapidapi.com";
    String apiKEY = Keys.openWeatherKEY;

    final response = await http.get(
      Uri(
        scheme: "https", 
        host: url, 
        path: "weather",
        queryParameters: {
          "lat":lat,
          "lon":long,
          "units":"metric",
        }
      ),
      headers: {
        "Host":headerHost,
        'X-RapidAPI-Host': headerHost,
        'X-RapidAPI-Key': apiKEY
      }
    );

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body); 
      return TodayWeather.fromJson(body);
    }
    else{
      throw Exception("Unable to perform request!");
    }

  }
}