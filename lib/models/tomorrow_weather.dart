class TomorrowWeather {
  final double temperature;
  final double humidity;
  final double windSpeed;
  final double pressure;
  final double uvIndex;
  final double visibility;
  final int weatherCode;
  final DateTime time;
  final double latitude;
  final double longitude;

  TomorrowWeather({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.uvIndex,
    required this.visibility,
    required this.weatherCode,
    required this.time,
    required this.latitude,
    required this.longitude,
  });

  factory TomorrowWeather.fromJson(Map<String, dynamic> json) {
    return TomorrowWeather(
      temperature: (json['temperature'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      pressure: (json['pressureSurfaceLevel'] as num).toDouble(),
      uvIndex: (json['uvIndex'] as num).toDouble(),
      visibility: (json['visibility'] as num).toDouble(),
      weatherCode: json['weatherCode'] as int,
      time: DateTime.parse(json['time']),
      latitude: (json['location']?['lat'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['location']?['lon'] as num?)?.toDouble() ?? 0.0,
    );
  }
} 