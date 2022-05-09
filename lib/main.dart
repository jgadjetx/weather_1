import 'dart:io';
import 'package:flutter/material.dart';
import 'package:weather_one/Screens/Home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_one/cubit/location_cubit.dart';
import 'package:weather_one/cubit/todayweather_cubit.dart';
import 'package:weather_one/cubit/weeksweather_cubit.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
          create: (BuildContext context) => LocationCubit(),
        ),
        BlocProvider<TodayweatherCubit>(
          create: (BuildContext context) => TodayweatherCubit(),
        ),
        BlocProvider<WeeksweatherCubit>(
          create: (BuildContext context) => WeeksweatherCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Weather 1',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            bodyText2: TextStyle(
              color: Colors.white,
            ),
          )
        ),
        home: Home()
      ),
    ); 
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
