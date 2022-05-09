part of 'weeksweather_cubit.dart';

@immutable
abstract class WeeksweatherState {}

class WeeksweatherInitial extends WeeksweatherState {}

class WeeksweatherLoaded extends WeeksweatherState {
  final List<DailyWeather> fiveDayWeather;

  WeeksweatherLoaded({required this.fiveDayWeather});
}
