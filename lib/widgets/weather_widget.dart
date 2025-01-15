import 'package:flutter/material.dart';
import '../models/tomorrow_weather.dart';

class WeatherWidget extends StatelessWidget {
  final TomorrowWeather weather;

  const WeatherWidget({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            weather.areaName,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            '${weather.temperature.round()}°C',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            weather.weatherMain,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
} 