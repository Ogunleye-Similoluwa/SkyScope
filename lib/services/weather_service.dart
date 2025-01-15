import 'package:dio/dio.dart';
import '../models/tomorrow_weather.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String apiKey;
  
  WeatherService(this.apiKey) {
    _dio.options.baseUrl = 'https://api.tomorrow.io/v4';
  }

  Future<TomorrowWeather> getCurrentWeather(double lat, double lon) async {
    try {
      final response = await _dio.get(
        '/weather/realtime',
        queryParameters: {
          'apikey': apiKey,
          'location': '$lat,$lon',
          'units': 'metric',
          'fields': [
            'temperature',
            'humidity',
            'windSpeed',
            'pressureSurfaceLevel',
            'uvIndex',
            'visibility',
            'weatherCode'
          ],
        },
      );

      final data = response.data['data'];
      final values = data['values'];
      values['time'] = data['time'];
      values['location'] = {'lat': lat, 'lon': lon};

      return TomorrowWeather.fromJson(values);
    } catch (e) {
      print('Error in getCurrentWeather: $e');
      rethrow;
    }
  }

  Future<List<TomorrowWeather>> getForecast(double lat, double lon) async {
    try {
      final response = await _dio.get(
        '/weather/forecast',
        queryParameters: {
          'apikey': apiKey,
          'location': '$lat,$lon',
          'units': 'metric',
          'timesteps': '1h',
          'fields': [
            'temperature',
            'humidity',
            'windSpeed',
            'pressureSurfaceLevel',
            'uvIndex',
            'visibility',
            'weatherCode'
          ],
        },
      );

      final timelines = response.data['timelines']['hourly'] as List;
      return timelines.map((item) {
        final values = item['values'];
        values['time'] = item['time'];
        values['location'] = {'lat': lat, 'lon': lon};
        return TomorrowWeather.fromJson(values);
      }).toList();
    } catch (e) {
      print('Error in getForecast: $e');
      rethrow;
    }
  }
} 