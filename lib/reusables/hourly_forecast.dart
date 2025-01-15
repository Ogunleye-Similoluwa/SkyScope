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

  IconData _getWeatherIcon(String iconCode) {
    switch (iconCode) {
      case '01d':
        return Icons.wb_sunny;
      case '01n':
        return Icons.nights_stay;
      case '02d':
      case '02n':
        return Icons.cloud;
      case '03d':
      case '03n':
      case '04d':
      case '04n':
        return Icons.cloud_queue;
      case '09d':
      case '09n':
        return Icons.grain;
      case '10d':
      case '10n':
        return Icons.beach_access;
      case '11d':
      case '11n':
        return Icons.flash_on;
      case '13d':
      case '13n':
        return Icons.ac_unit;
      case '50d':
      case '50n':
        return Icons.blur_on;
      default:
        return Icons.wb_sunny;
    }
  }
} 