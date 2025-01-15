import 'package:dio/dio.dart';
import '../models/tomorrow_weather.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String apiKey;
  
  WeatherService(this.apiKey) {
    _dio.options.baseUrl = 'https://api.tomorrow.io/v4';
  }

  Future<TomorrowWeather> getCurrentWeather(double lat, double lon) async {
    final response = await _dio.get(
      '/weather/realtime',
      queryParameters: {
        'apikey': apiKey,
        'location': '$lat,$lon',
        'units': 'metric'
      },
    );
    return TomorrowWeather.fromJson(response.data['data']['values']);
  }

  Future<List<TomorrowWeather>> getForecast(double lat, double lon) async {
    final response = await _dio.get(
      '/weather/forecast',
      queryParameters: {
        'apikey': apiKey,
        'location': '$lat,$lon',
        'units': 'metric'
      },
    );
    
    final List<dynamic> timelines = response.data['timelines']['daily'];
    return timelines.map((data) => TomorrowWeather.fromJson(data['values'])).toList();
  }
} 