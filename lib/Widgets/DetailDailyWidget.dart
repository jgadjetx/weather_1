import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_one/ViewModels/DailyWeatherViewModel.dart';

class DetailDailyWidget extends StatelessWidget {
  const DetailDailyWidget({Key? key, required this.weatherData}) : super(key: key);

  final DailyWeatherViewModel weatherData;
  
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 160,
      margin: EdgeInsets.only(bottom: 5,top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey)
      ),
      child: Row(
        children:[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Jiffy(weatherData.dateTime).format("HH:mm"), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                       weatherData.temp_Max.round().toString() + " \u2103",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      weatherData.temp_Min.round().toString() + " \u2103",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(weatherData.description),
              ],
            )
          ),
          
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Humidty"),
                Text("${weatherData.humidity}%"),
                SizedBox(
                  height: 10,
                ),
                Text("Wind Speed"),
                Text("${weatherData.windSpeed} km/h")
              ],
            )
          ),

          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("http://openweathermap.org/img/wn/${weatherData.iconName}@2x.png")
                    ),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  width: 150, 
                  height: 100,
                ),
              ],
            )
          ),
        ]
      ),
    );
  }

}