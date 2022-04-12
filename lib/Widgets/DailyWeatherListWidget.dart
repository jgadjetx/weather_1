import 'package:flutter/material.dart';
import 'package:weather_one/ViewModels/DailyWeatherViewModel.dart';
import 'package:weather_one/Widgets/DailyWeatherWidget.dart';

class DailyWeatherListWidget extends StatefulWidget {
  const DailyWeatherListWidget({Key? key, required this.dailyWeatherViewModel}) : super(key: key);

  final List<DailyWeatherViewModel>? dailyWeatherViewModel;

  @override
  State<DailyWeatherListWidget> createState() => _DailyWeatherListWidgetState();
}

class _DailyWeatherListWidgetState extends State<DailyWeatherListWidget> {

  @override
  Widget build(BuildContext context) {

    return Container(
      child: ListView.builder(
        itemCount: widget.dailyWeatherViewModel?.length, 
        itemBuilder: (BuildContext context, int index) {  
          
          return DailyWeatherWidget(weatherData:widget.dailyWeatherViewModel![index]);
        },
      )
    );
  }
}