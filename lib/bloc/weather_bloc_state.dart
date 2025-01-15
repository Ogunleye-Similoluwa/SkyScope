part of 'weather_bloc_bloc.dart';

abstract class WeatherBlocState extends Equatable {
  const WeatherBlocState();
  
  @override
  List<Object?> get props => [];
}

class WeatherBlocInitial extends WeatherBlocState {}

class WeatherBlocLoading extends WeatherBlocState {}

class WeatherBlocSuccess extends WeatherBlocState {
  final TomorrowWeather currentWeather;
  final List<TomorrowWeather> forecast;
  final List<TomorrowWeather> hourlyForecast;
  final List<WeatherAlert> weatherAlerts;
  final List<String> savedLocations;

  const WeatherBlocSuccess({
    required this.currentWeather,
    required this.forecast,
    required this.hourlyForecast,
    required this.weatherAlerts,
    this.savedLocations = const [],
  });

  WeatherBlocSuccess copyWith({
    TomorrowWeather? currentWeather,
    List<TomorrowWeather>? forecast,
    List<TomorrowWeather>? hourlyForecast,
    List<WeatherAlert>? weatherAlerts,
    List<String>? savedLocations,
  }) {
    return WeatherBlocSuccess(
      currentWeather: currentWeather ?? this.currentWeather,
      forecast: forecast ?? this.forecast,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
      weatherAlerts: weatherAlerts ?? this.weatherAlerts,
      savedLocations: savedLocations ?? this.savedLocations,
    );
  }

  @override
  List<Object?> get props => [currentWeather, forecast, hourlyForecast, weatherAlerts, savedLocations];
}

class WeatherBlocError extends WeatherBlocState {
  final String message;
  final ErrorType type;

  const WeatherBlocError({
    required this.message,
    required this.type,
  });

  @override
  List<Object> get props => [message, type];
}

enum ErrorType {
  location,
  network,
  api,
  unknown,
}