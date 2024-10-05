import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../data/api_key.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
        Position position = await Geolocator.getCurrentPosition();
        double? latitude = position.latitude;
        double? longitude = position.longitude;
        Weather currentWeather = await wf.currentWeatherByLocation(
          latitude,
          longitude,
        );

        List<Weather> forecast = await wf.fiveDayForecastByLocation(
          latitude,
          longitude,
        );

        emit(WeatherBlocSuccess(currentWeather, forecast));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}