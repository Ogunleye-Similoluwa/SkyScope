import 'package:flutter/material.dart';
import 'package:simple_weather_application/models/tomorrow_weather.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

class HourlyForecast extends StatelessWidget {
  final List<TomorrowWeather> hourlyData;

  const HourlyForecast({
    Key? key,
    required this.hourlyData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Hourly Forecast',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyData.length,
              itemBuilder: (context, index) {
                final hourData = hourlyData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(hourData.time),  
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Icon(
                        _getWeatherIcon(hourData.weatherCode),
                        size: 24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${hourData.temperature.toStringAsFixed(1)}°',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(int weatherCode) {
    // Tomorrow.io weather codes
    switch (weatherCode) {
      case 1000: // Clear, Sunny
        return Icons.wb_sunny;
      case 1100: // Mostly Clear
      case 1101: // Partly Cloudy
        return Icons.wb_cloudy;
      case 1102: // Mostly Cloudy
      case 1001: // Cloudy
        return Icons.cloud;
      case 4000: // Drizzle
      case 4001: // Rain
        return Icons.grain;
      case 4200: // Light Rain
      case 4201: // Heavy Rain
        return Icons.beach_access;
      case 5000: // Snow
      case 5001: // Flurries
      case 5100: // Light Snow
      case 5101: // Heavy Snow
        return Icons.ac_unit;
      case 6000: // Freezing Drizzle
      case 6001: // Freezing Rain
      case 6200: // Light Freezing Rain
      case 6201: // Heavy Freezing Rain
        return Icons.ac_unit;
      case 7000: // Ice Pellets
      case 7101: // Heavy Ice Pellets
      case 7102: // Light Ice Pellets
        return Icons.ac_unit;
      case 8000: // Thunderstorm
        return Icons.flash_on;
      default:
        return Icons.wb_sunny;
    }
  }
} 