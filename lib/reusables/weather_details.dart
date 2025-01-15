// components/weather_details.dart
import 'package:flutter/material.dart';

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
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDetailItem(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '$humidity%',
                ),
                _buildDetailItem(
                  icon: Icons.air,
                  label: 'Wind',
                  value: '$windSpeed km/h',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDetailItem(
                  icon: Icons.wb_sunny,
                  label: 'UV Index',
                  value: uvIndex.round().toString(),
                ),
                _buildDetailItem(
                  icon: Icons.visibility,
                  label: 'Visibility',
                  value: '${visibility.round()}km',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

