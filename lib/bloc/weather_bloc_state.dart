part of 'weather_bloc_bloc.dart';

abstract class WeatherBlocState extends Equatable {
  const WeatherBlocState();

  @override
  List<Object> get props => [];
}

class WeatherBlocInitial extends WeatherBlocState {}

class WeatherBlocLoading extends WeatherBlocState {}

class WeatherBlocFailure extends WeatherBlocState {}

class WeatherBlocSuccess extends WeatherBlocState {
  final TomorrowWeather currentWeather;
  final List<TomorrowWeather> hourlyForecast;

  const WeatherBlocSuccess(this.currentWeather, this.hourlyForecast);

  @override
  List<Object> get props => [currentWeather, hourlyForecast];
}
