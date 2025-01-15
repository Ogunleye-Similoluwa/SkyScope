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

  String _getWeatherDescription(String code) {
    switch (code) {
      case '1000': return 'CLEAR';
      case '1100': return 'MOSTLY CLEAR';
      case '1101': return 'PARTLY CLOUDY';
      case '1102': return 'MOSTLY CLOUDY';
      case '1001': return 'CLOUDY';
      case '4000': return 'RAIN';
      case '4001': return 'LIGHT RAIN';
      case '4200': return 'SNOW';
      default: return 'CLEAR';
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
                _getWeatherDescription(weather.weatherCode.toString()),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isCurrentDay ? 24 : 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            WeatherDetails(
              humidity: weather.humidity.toDouble() ?? 0,
              windSpeed: weather.windSpeed ?? 0,
              pressure: weather.pressure ?? 0,
              uvIndex: weather.uvIndex.toDouble() ?? 0,
              visibility: weather.visibility.toDouble() ?? 0,
            ),
          ],
        ),
      ),
    );
  }
}