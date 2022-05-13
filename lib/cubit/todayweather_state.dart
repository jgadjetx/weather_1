part of 'todayweather_cubit.dart';

@immutable
abstract class TodayweatherState {}

class TodayweatherInitial extends TodayweatherState {}

class TodayWeatherLoaded extends TodayweatherState{

  final TodayWeather todayWeather;

  TodayWeatherLoaded({required this.todayWeather});
}

class TodayWeatherLive extends TodayweatherState{

  final TodayWeather todayWeatherLive;

  TodayWeatherLive({required this.todayWeatherLive});
}

class TodayWeatherFailed extends TodayweatherState{}