import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/api_key.dart';
import '../models/tomorrow_weather.dart';
import '../models/weather_alert.dart';
import '../services/location_service.dart';

class WeatherService {
  final LocationService _locationService = LocationService();

  Future<String> getLocationName(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json'
        ),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'];
        
        // Create a more concise location string
        final List<String> locationParts = [];
        
        if (address['city'] != null) {
          locationParts.add(address['city']);
        } else if (address['town'] != null) {
          locationParts.add(address['town']);
        } else if (address['village'] != null) {
          locationParts.add(address['village']);
        }
        
        if (address['state'] != null) {
          locationParts.add(address['state']);
        }
        
        if (address['country'] != null) {
          locationParts.add(address['country']);
        }
        
        return locationParts.join(', ');
      }
      return 'Unknown Location';
    } catch (e) {
      return 'Unknown Location';
    }
  }

  Future<Map<String, dynamic>> getWeatherData(double lat, double lon) async {
    try {
      final fields = [
        'temperature',
        'temperatureApparent',
        'humidity',
        'windSpeed',
        'weatherCode',
        'precipitationProbability',
        'uvIndex',
        'cloudCover',
        'visibility',
        'pressureSeaLevel'
      ];

      final response = await http.get(
        Uri.parse(
          '$BASE_URL/timelines?location=$lat,$lon&fields=${fields.join(',')}&timesteps=1h&units=metric&apikey=$TOMORROW_API_KEY',
        ),
      );

      print('API Response: ${response.body}'); // Debug print

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['data'] == null || data['data']['timelines'] == null) {
          throw Exception('Invalid data format from API');
        }

        final intervals = data['data']['timelines'][0]['intervals'];
        final locationName = await getLocationName(lat, lon);
        
        final current = TomorrowWeather.fromJson(
          {
            ...intervals[0]['values'],
            'time': intervals[0]['startTime'],
          },
          areaName: locationName,
        );
        
        final hourlyData = List<TomorrowWeather>.from(
          intervals.map((interval) => TomorrowWeather.fromJson(
            {
              ...interval['values'],
              'time': interval['startTime'],
            },
            areaName: 'Current Location',
          )),
        );

        return {
          'current': current,
          'hourly': hourlyData,
        };
      } else {
        print('Error status code: ${response.statusCode}');
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather: $e'); // Debug print
      rethrow;
    }
  }
}