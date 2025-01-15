class TomorrowWeather {
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int weatherCode;
  final double precipitation;
  final double uvIndex;
  final DateTime time;
  final double? cloudCover;
  final double visibility;
  final double pressure;
  final String areaName;

  TomorrowWeather({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.precipitation,
    required this.uvIndex,
    required this.time,
    this.cloudCover,
    required this.visibility,
    required this.pressure,
    required this.areaName,
  });

  factory TomorrowWeather.fromJson(Map<String, dynamic> json, {String areaName = ''}) {
    return TomorrowWeather(
      temperature: json['temperature']?.toDouble() ?? 0.0,
      feelsLike: json['temperatureApparent']?.toDouble() ?? 0.0,
      humidity: json['humidity']?.toInt() ?? 0,
      windSpeed: json['windSpeed']?.toDouble() ?? 0.0,
      weatherCode: json['weatherCode'] ?? 0,
      precipitation: json['precipitationProbability']?.toDouble() ?? 0.0,
      uvIndex: json['uvIndex']?.toDouble() ?? 0.0,
      time: DateTime.now(),
      cloudCover: json['cloudCover']?.toDouble(),
      visibility: json['visibility']?.toDouble() ?? 0.0,
      pressure: json['pressureSeaLevel']?.toDouble() ?? 0.0,
      areaName: areaName,
    );
  }

  String get weatherMain {
    switch (weatherCode) {
      case 1000: return 'Clear';
      case 1100: return 'Mostly Clear';
      case 1101: return 'Partly Cloudy';
      case 1102: return 'Mostly Cloudy';
      case 1001: return 'Cloudy';
      case 4000: return 'Rain';
      case 4001: return 'Light Rain';
      case 4200: return 'Light Rain';
      case 4201: return 'Heavy Rain';
      default: return 'Unknown';
    }
  }
}