part of 'weather_bloc_bloc.dart';

class WeatherBlocState extends Equatable {
  const WeatherBlocState();

  @override
  List<Object> get props => [];
}

class WeatherBlocInitial extends WeatherBlocState {}

class WeatherBlocLoading extends WeatherBlocState {}

class WeatherBlocFailure extends WeatherBlocState {}

class WeatherBlocSuccess extends WeatherBlocState {
  final Weather currentWeather;
  final List<Weather> forecast;

  const WeatherBlocSuccess(this.currentWeather, this.forecast);

  @override
  List<Object> get props => [currentWeather, forecast];
}