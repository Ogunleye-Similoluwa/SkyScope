import 'package:flutter/material.dart';

class SettingsModel {
  final bool useCelsius;
  final bool useMetric;
  final String themeMode;
  final String colorScheme;
  final bool showNotifications;
  final bool severeWeatherAlerts;
  final bool dailyForecastNotification;
  final int refreshInterval;
  final List<String> savedLocations;

  SettingsModel({
    required this.useCelsius,
    required this.useMetric,
    required this.themeMode,
    required this.colorScheme,
    required this.showNotifications,
    required this.severeWeatherAlerts,
    required this.dailyForecastNotification,
    required this.refreshInterval,
    this.savedLocations = const [],
  });

  SettingsModel copyWith({
    bool? useCelsius,
    bool? useMetric,
    String? themeMode,
    String? colorScheme,
    bool? showNotifications,
    bool? severeWeatherAlerts,
    bool? dailyForecastNotification,
    int? refreshInterval,
    List<String>? savedLocations,
  }) {
    return SettingsModel(
      useCelsius: useCelsius ?? this.useCelsius,
      useMetric: useMetric ?? this.useMetric,
      themeMode: themeMode ?? this.themeMode,
      colorScheme: colorScheme ?? this.colorScheme,
      showNotifications: showNotifications ?? this.showNotifications,
      severeWeatherAlerts: severeWeatherAlerts ?? this.severeWeatherAlerts,
      dailyForecastNotification: dailyForecastNotification ?? this.dailyForecastNotification,
      refreshInterval: refreshInterval ?? this.refreshInterval,
      savedLocations: savedLocations ?? this.savedLocations,
    );
  }
}