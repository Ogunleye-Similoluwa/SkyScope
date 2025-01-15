import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel {
  final bool useCelsius;
  final bool use24HourFormat;
  final bool enableNotifications;
  final bool enableDailyForecast;

  SettingsModel({
    this.useCelsius = true,
    this.use24HourFormat = true,
    this.enableNotifications = true,
    this.enableDailyForecast = true,
  });

  SettingsModel copyWith({
    bool? useCelsius,
    bool? use24HourFormat,
    bool? enableNotifications,
    bool? enableDailyForecast,
  }) {
    return SettingsModel(
      useCelsius: useCelsius ?? this.useCelsius,
      use24HourFormat: use24HourFormat ?? this.use24HourFormat,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      enableDailyForecast: enableDailyForecast ?? this.enableDailyForecast,
    );
  }
}

class SettingsCubit extends Cubit<SettingsModel> {
  final SharedPreferences prefs;

  SettingsCubit(this.prefs) : super(SettingsModel()) {
    _loadSettings();
  }

  void _loadSettings() {
    emit(SettingsModel(
      useCelsius: prefs.getBool('useCelsius') ?? true,
      use24HourFormat: prefs.getBool('use24HourFormat') ?? true,
      enableNotifications: prefs.getBool('enableNotifications') ?? true,
      enableDailyForecast: prefs.getBool('enableDailyForecast') ?? true,
    ));
  }

  void toggleTemperatureUnit() {
    prefs.setBool('useCelsius', !state.useCelsius);
    emit(state.copyWith(useCelsius: !state.useCelsius));
  }

  void toggleTimeFormat() {
    prefs.setBool('use24HourFormat', !state.use24HourFormat);
    emit(state.copyWith(use24HourFormat: !state.use24HourFormat));
  }

  void toggleNotifications() {
    prefs.setBool('enableNotifications', !state.enableNotifications);
    emit(state.copyWith(enableNotifications: !state.enableNotifications));
  }

  void toggleDailyForecast() {
    prefs.setBool('enableDailyForecast', !state.enableDailyForecast);
    emit(state.copyWith(enableDailyForecast: !state.enableDailyForecast));
  }
}