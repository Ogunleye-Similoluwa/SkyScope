import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/tomorrow_weather.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  NotificationService(this.notificationsPlugin) {
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await notificationsPlugin.initialize(initSettings);
  }

  Future<void> showWeatherAlert(TomorrowWeather weather) async {
    const androidDetails = AndroidNotificationDetails(
      'weather_alerts',
      'Weather Alerts',
      importance: Importance.high,
    );
    
    const iosDetails = DarwinNotificationDetails();
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await notificationsPlugin.show(
      0,
      'Weather Update',
      'Current temperature in ${weather.areaName}: ${weather.temperature.round()}°C',
      details,
    );
  }
} 