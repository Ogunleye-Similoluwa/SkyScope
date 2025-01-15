import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import '../services/weather_service.dart';
import '../models/tomorrow_weather.dart';
import '../models/weather_alert.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  final WeatherService _weatherService = WeatherService();

  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        final weatherData = await _weatherService.getWeatherData(
          event.position.latitude,
          event.position.longitude,
        );

        final current = weatherData['current'] as TomorrowWeather;
        final hourly = weatherData['hourly'] as List<TomorrowWeather>;

        if (current != null && hourly.isNotEmpty) {
          emit(WeatherBlocSuccess(current, hourly));
        } else {
          emit(WeatherBlocFailure());
        }
      } catch (e) {
        print('Error in bloc: $e'); // Debug print
        emit(WeatherBlocFailure());
      }
    });
  }
}