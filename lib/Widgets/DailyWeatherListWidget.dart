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

  
  Future<List<DailyWeatherViewModel>> sortDates() async{

    List<DailyWeatherViewModel> sortedDailyWeatherViewModel = [];

    DateTime todayNine = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,9,00,00);
    DateTime earliestDateOnVM = widget.dailyWeatherViewModel![0].dateTime;
    
    if(earliestDateOnVM.isBefore(todayNine)){
      //take all 9am

      for(int i = 0; i <= widget.dailyWeatherViewModel!.length - 1; i++){

        if(widget.dailyWeatherViewModel![i].dateTime == todayNine){
          sortedDailyWeatherViewModel.add(widget.dailyWeatherViewModel![i]);
          todayNine = todayNine.add(Duration(days: 1));
        }
 
      }

    }
    else{
      //take first datetime, then all following 9am
      sortedDailyWeatherViewModel.add(widget.dailyWeatherViewModel![0]);
      todayNine = todayNine.add(Duration(days: 1));

      for(int i = 1; i <= widget.dailyWeatherViewModel!.length -1; i++){

        if(widget.dailyWeatherViewModel![i].dateTime == todayNine){
          sortedDailyWeatherViewModel.add(widget.dailyWeatherViewModel![i]);
          todayNine = todayNine.add(Duration(days: 1));
        }

      }
    }

    return sortedDailyWeatherViewModel;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: FutureBuilder<List<DailyWeatherViewModel>>(
        future: sortDates(),
        builder: (BuildContext context, snapshot) { 

          if( snapshot.connectionState == ConnectionState.waiting){
            return Text("Sorting list");
          }
          else{
            if (snapshot.hasError){
              return Text('An error occured.');
            }
            else if (snapshot.hasData  && snapshot.data!.length > 0) {
              
              List<DailyWeatherViewModel>? data = snapshot.data;

              return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (BuildContext context, int index){

                  return DailyWeatherWidget(weatherData:data[index]);
              });
              
            }
          }

          return Container();
        },    
      )
    );
  }
}