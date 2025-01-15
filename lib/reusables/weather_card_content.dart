import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_weather_application/models/tomorrow_weather.dart';
import 'package:weather/weather.dart';
import 'weather_icon.dart';
import 'weather_details.dart';

class WeatherCardContent extends StatelessWidget {
  final TomorrowWeather weather;
  final bool isCurrentDay;
  final int index;

  const WeatherCardContent({
    Key? key,
    required this.weather,
    required this.isCurrentDay,
    required this.index,
  }) : super(key: key);

  String _getWeatherDescription(int code) {
    switch (code) {
      case 1000: return 'Clear';
      case 1100: return 'Mostly Clear';
      case 1101: return 'Partly Cloudy';
      case 1102: return 'Mostly Cloudy';
      case 1001: return 'Cloudy';
      case 4000: return 'Rain';
      case 4001: return 'Light Rain';
      case 4200: return 'Snow';
      default: return 'Clear';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('EEEE').format(DateTime.now().add(Duration(days: index))),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isCurrentDay ? 28 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('MMM d').format(DateTime.now().add(Duration(days: index))),
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isCurrentDay ? 20 : 16,
                        ),
                      ),
                    ],
                  ),
                ),
                WeatherIcon(code: weather.weatherCode),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                '${weather.temperature.toStringAsFixed(1)}°C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isCurrentDay ? 72 : 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                _getWeatherDescription(weather.weatherCode),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isCurrentDay ? 24 : 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            WeatherDetails(
              humidity: weather.humidity,
              windSpeed: weather.windSpeed,
              pressure: weather.pressure,
              uvIndex: weather.uvIndex,
              visibility: weather.visibility,
            ),
          ],
        ),
      ),
    );
  }
}