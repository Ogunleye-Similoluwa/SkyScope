part of 'weather_bloc_bloc.dart';

abstract class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object?> get props => [];
}

class FetchWeather extends WeatherBlocEvent {
  final Position position;

  const FetchWeather(this.position);

  @override
  List<Object> get props => [position];
}

class SearchLocation extends WeatherBlocEvent {
  final String cityName;

  const SearchLocation(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class SaveLocation extends WeatherBlocEvent {
  final String cityName;

  const SaveLocation(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class RemoveLocation extends WeatherBlocEvent {
  final String cityName;

  const RemoveLocation(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class RefreshWeather extends WeatherBlocEvent {}
