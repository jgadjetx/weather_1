import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:weather_one/Providers/WeatherProvider.dart';
import 'package:weather_one/ViewModels/DailyWeatherViewModel.dart';
import 'package:weather_one/Widgets/DetailDailyWidget.dart';

class DailyWeatherDetails extends StatelessWidget {
  const DailyWeatherDetails({Key? key, required this.selectedDateTime}) : super(key: key);

  final DateTime selectedDateTime;

  Future<List<DailyWeatherViewModel>> sortDates(List<DailyWeatherViewModel>? dailyWeatherViewModel) async{
    List<DailyWeatherViewModel> sortedDailyWeatherViewModel = [];

    int selectedYear = selectedDateTime.year;
    int selectedMonth = selectedDateTime.month;
    int selectedDay = selectedDateTime.day;

    for(int i = 0; i <= dailyWeatherViewModel!.length -1;i++){

      DateTime viewModelDate = dailyWeatherViewModel[i].dateTime;

      int viewModelDateYear = viewModelDate.year;
      int viewModelDateMonth = viewModelDate.month;
      int viewModelDateDay = viewModelDate.day;

      if(selectedYear == viewModelDateYear && selectedMonth == viewModelDateMonth && selectedDay == viewModelDateDay){
        sortedDailyWeatherViewModel.add(dailyWeatherViewModel[i]);
      }
    }

    return sortedDailyWeatherViewModel;
  }
  
  @override
  Widget build(BuildContext context) {
    
    WeatherProvider weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Jiffy(selectedDateTime).format("dd MMMM yyyy")),
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder<List<DailyWeatherViewModel>>(
          future: sortDates(weatherProvider.dailyWeatherViewModel),
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

                    return DetailDailyWidget(weatherData:data[index]);
                });
                
              }
            }

            return Container();
          }
        )
      )
    );
  }
}