// components/weather_details.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tomorrow_weather.dart';

class WeatherDetails extends StatelessWidget {
  final TomorrowWeather weather;
  final int index;

  const WeatherDetails({
    Key? key,
    required this.weather,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _buildDetailItem('Humidity', '${weather.humidity}%', 'assets/humidity.jpg'),
            ),
            Expanded(
              child: _buildDetailItem('Wind', '${weather.windSpeed} km/h', 'assets/wind.jpg'),
            ),
            Expanded(
              child: _buildDetailItem('Feels Like', '${weather.feelsLike.round()}°C', 'assets/13.png'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _buildDetailItem(
                'UV Index',
                '${weather.uvIndex.round()}',
                'assets/11.png'
              ),
            ),
            Expanded(
              child: _buildDetailItem(
                'Visibility',
                '${weather.visibility.round()}km',
                'assets/12.png'
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, String iconPath) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(iconPath, height: 30),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

