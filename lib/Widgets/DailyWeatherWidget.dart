import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:weather_one/Screens/DailyWeatherDetails.dart';
import 'package:weather_one/ViewModels/DailyWeatherViewModel.dart';

class DailyWeatherWidget extends StatelessWidget {
  const DailyWeatherWidget({Key? key, required this.weatherData}) : super(key: key);

  final DailyWeatherViewModel weatherData;
  
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        DateTime selectedDateTime = weatherData.dateTime;

        
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DailyWeatherDetails(selectedDateTime: selectedDateTime)));
      },
      child: Container(
        height: 120,
        margin: EdgeInsets.only(bottom: 10),
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
                  Text(Jiffy(weatherData.dateTime).format("dd MMMM")),
                  Text(Jiffy(weatherData.dateTime).format("EEEE")),
                  Text(weatherData.description),
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
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
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
                  )
                ],
              )
            )
          ]
        ),
      ),
    );
  }

}