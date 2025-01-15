import 'package:flutter_bloc/flutter_bloc.dart';
import '../reusables/setting_model.dart';

class SettingsCubit extends Cubit<SettingsModel> {
  SettingsCubit() : super(SettingsModel(
    useCelsius: true,
    useMetric: true,
    themeMode: 'system',
    colorScheme: 'default',
    showNotifications: true,
    severeWeatherAlerts: true,
    dailyForecastNotification: true,
    refreshInterval: 60,
  ));

  void toggleTemperatureUnit() {
    emit(state.copyWith(useCelsius: !state.useCelsius));
  }

  void setThemeMode(String mode) {
    emit(state.copyWith(themeMode: mode));
  }

  void addFavoriteLocation(String location) {
    final updatedLocations = List<String>.from(state.savedLocations)..add(location);
    emit(state.copyWith(savedLocations: updatedLocations));
  }

  void removeFavoriteLocation(String location) {
    final updatedLocations = List<String>.from(state.savedLocations)..remove(location);
    emit(state.copyWith(savedLocations: updatedLocations));
  }

  void toggleNotifications() {
    emit(state.copyWith(showNotifications: !state.showNotifications));
  }

  void setRefreshInterval(int minutes) {
    emit(state.copyWith(refreshInterval: minutes));
  }

  void toggleSevereWeatherAlerts() {
    emit(state.copyWith(severeWeatherAlerts: !state.severeWeatherAlerts));
  }

  void toggleDailyForecast() {
    emit(state.copyWith(dailyForecastNotification: !state.dailyForecastNotification));
  }

  void setColorScheme(String scheme) {
    emit(state.copyWith(colorScheme: scheme));
  }

  void toggleMetricSystem() {
    emit(state.copyWith(useMetric: !state.useMetric));
  }
}