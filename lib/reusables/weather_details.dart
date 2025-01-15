// components/weather_details.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherDetails extends StatelessWidget {
  final double humidity;
  final double windSpeed;
  final double pressure;
  final double uvIndex;
  final double visibility;

  const WeatherDetails({
    Key? key,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.uvIndex,
    required this.visibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDetailColumn('Humidity', '${humidity.toStringAsFixed(0)}%'),
        _buildDetailColumn('Wind', '${windSpeed.toStringAsFixed(1)} m/s'),
        _buildDetailColumn('Pressure', '${pressure.toStringAsFixed(0)} hPa'),
      ],
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

