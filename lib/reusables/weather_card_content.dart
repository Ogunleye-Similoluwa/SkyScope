import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tomorrow_weather.dart';
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
                '${weather.temperature.round()}°C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isCurrentDay ? 72 : 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                weather.weatherCode.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isCurrentDay ? 24 : 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            WeatherDetails(weather: weather, index: index),
          ],
        ),
      ),
    );
  }
}