import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simple_weather_application/services/weather_service.dart';
import 'package:weather/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_alert.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  final WeatherService weatherService;
  final SharedPreferences prefs;
  Timer? _refreshTimer;

  WeatherBlocBloc({
    required this.weatherService,
    required this.prefs,
  }) : super(WeatherBlocInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<SearchLocation>(_onSearchLocation);
    on<SaveLocation>(_onSaveLocation);
    on<RemoveLocation>(_onRemoveLocation);
    on<RefreshWeather>(_onRefreshWeather);

    _startPeriodicRefresh();
  }

  void _startPeriodicRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 30),
      (_) => add(RefreshWeather()),
    );
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherBlocState> emit,
  ) async {
    try {
      emit(WeatherBlocLoading());

      final currentWeather = await weatherService.getCurrentWeather(
        event.position.latitude,
        event.position.longitude,
      );

      final forecast = await weatherService.getForecast(
        event.position.latitude,
        event.position.longitude,
      );

      final savedLocations = prefs.getStringList('saved_locations') ?? [];

      emit(WeatherBlocSuccess(
        currentWeather: currentWeather,
        forecast: forecast,
        hourlyForecast: forecast.take(24).toList(),
        weatherAlerts: _getWeatherAlerts(currentWeather, forecast),
        savedLocations: savedLocations,
      ));
    } catch (e, stackTrace) {
      print('Error fetching weather: $e');
      print('Stack trace: $stackTrace');
      emit(WeatherBlocError(
        message: 'Failed to fetch weather data: ${e.toString()}',
        type: ErrorType.api,
      ));
    }
  }

  Future<void> _onSearchLocation(
    SearchLocation event,
    Emitter<WeatherBlocState> emit,
  ) async {
    try {
      emit(WeatherBlocLoading());

      // Search for location using lat/lon (you'll need to get these from a geocoding service)
      final currentWeather = await weatherService.getCurrentWeather(0, 0); // TODO: Add proper coordinates
      final forecast = await weatherService.getForecast(0, 0);

      final savedLocations = prefs.getStringList('saved_locations') ?? [];

      emit(WeatherBlocSuccess(
        currentWeather: currentWeather,
        forecast: forecast,
        hourlyForecast: forecast.take(24).toList(),
        weatherAlerts: _getWeatherAlerts(currentWeather, forecast),
        savedLocations: savedLocations,
      ));
    } catch (e) {
      emit(WeatherBlocError(
        message: 'Failed to search location: ${e.toString()}',
        type: ErrorType.api,
      ));
    }
  }

  Future<void> _onSaveLocation(
    SaveLocation event,
    Emitter<WeatherBlocState> emit,
  ) async {
    if (state is WeatherBlocSuccess) {
      final currentState = state as WeatherBlocSuccess;
      final savedLocations = List<String>.from(currentState.savedLocations);
      
      if (!savedLocations.contains(event.cityName)) {
        savedLocations.add(event.cityName);
        await prefs.setStringList('saved_locations', savedLocations);
        
        emit(currentState.copyWith(savedLocations: savedLocations));
      }
    }
  }

  Future<void> _onRemoveLocation(
    RemoveLocation event,
    Emitter<WeatherBlocState> emit,
  ) async {
    if (state is WeatherBlocSuccess) {
      final currentState = state as WeatherBlocSuccess;
      final savedLocations = List<String>.from(currentState.savedLocations);
      
      savedLocations.remove(event.cityName);
      await prefs.setStringList('saved_locations', savedLocations);
      
      emit(currentState.copyWith(savedLocations: savedLocations));
    }
  }

  Future<void> _onRefreshWeather(
    RefreshWeather event,
    Emitter<WeatherBlocState> emit,
  ) async {
    if (state is WeatherBlocSuccess) {
      final currentState = state as WeatherBlocSuccess;
      final position = await Geolocator.getCurrentPosition();
      add(FetchWeather(position));
    }
  }

  List<WeatherAlert> _getWeatherAlerts(TomorrowWeather current, List<TomorrowWeather> forecast) {
    final alerts = <WeatherAlert>[];
    
    if (current.temperature > 35) {
      alerts.add(WeatherAlert(
        title: 'High Temperature Alert',
        description: 'Temperature exceeds 35°C',
        severity: 'High',
      ));
    } else if (current.temperature < 0) {
      alerts.add(WeatherAlert(
        title: 'Low Temperature Alert',
        description: 'Temperature below 0°C',
        severity: 'High',
      ));
    }

    // Add more weather code based alerts here
    return alerts;
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    return super.close();
  }
}