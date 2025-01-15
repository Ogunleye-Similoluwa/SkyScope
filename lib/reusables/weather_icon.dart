import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String code;

  const WeatherIcon({
    Key? key,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      _getWeatherIcon(code),
      color: Colors.white,
      size: 32,
    );
  }

  IconData _getWeatherIcon(String code) {
    switch (code) {
      case '1000': return Icons.wb_sunny;  // Clear
      case '1100': return Icons.wb_cloudy;  // Mostly Clear
      case '1101': return Icons.cloud;      // Partly Cloudy
      case '1102': return Icons.cloud;      // Mostly Cloudy
      case '1001': return Icons.cloud;      // Cloudy
      case '4000': return Icons.grain;      // Rain
      case '4001': return Icons.beach_access; // Light Rain
      case '4200': return Icons.ac_unit;    // Snow
      default: return Icons.wb_sunny;
    }
  }
}