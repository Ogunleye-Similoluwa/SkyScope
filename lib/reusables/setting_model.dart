import 'package:flutter/material.dart';

class SettingsModel {
  final bool useCelsius;
  final String themeMode;
  final List<String> favoriteLocations;
  final bool showNotifications;
  final int refreshInterval;

  SettingsModel({
    this.useCelsius = true,
    this.themeMode = 'system',
    this.favoriteLocations = const [],
    this.showNotifications = true,
    this.refreshInterval = 60,
  });

  SettingsModel copyWith({
    bool? useCelsius,
    String? themeMode,
    List<String>? favoriteLocations,
    bool? showNotifications,
    int? refreshInterval,
  }) {
    return SettingsModel(
      useCelsius: useCelsius ?? this.useCelsius,
      themeMode: themeMode ?? this.themeMode,
      favoriteLocations: favoriteLocations ?? this.favoriteLocations,
      showNotifications: showNotifications ?? this.showNotifications,
      refreshInterval: refreshInterval ?? this.refreshInterval,
    );
  }
}