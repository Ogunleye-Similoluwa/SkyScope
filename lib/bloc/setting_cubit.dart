import 'package:flutter_bloc/flutter_bloc.dart';
import '../reusables/setting_model.dart';

class SettingsCubit extends Cubit<SettingsModel> {
  SettingsCubit() : super(SettingsModel());

  void toggleTemperatureUnit() {
    emit(state.copyWith(useCelsius: !state.useCelsius));
  }

  void setThemeMode(String mode) {
    emit(state.copyWith(themeMode: mode));
  }

  void addFavoriteLocation(String location) {
    final updatedLocations = List<String>.from(state.favoriteLocations)..add(location);
    emit(state.copyWith(favoriteLocations: updatedLocations));
  }

  void removeFavoriteLocation(String location) {
    final updatedLocations = List<String>.from(state.favoriteLocations)..remove(location);
    emit(state.copyWith(favoriteLocations: updatedLocations));
  }

  void toggleNotifications() {
    emit(state.copyWith(showNotifications: !state.showNotifications));
  }

  void setRefreshInterval(int minutes) {
    emit(state.copyWith(refreshInterval: minutes));
  }
}