class TomorrowWeather {
  final double temperature;
  final double humidity;
  final double windSpeed;
  final double pressure;
  final double uvIndex;
  final double visibility;
  final String weatherCode;
  final DateTime time;
  final String areaName;
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
    this.areaName = '',
    this.latitude = 0,
    this.longitude = 0,
  });

  factory TomorrowWeather.fromJson(Map<String, dynamic> json) {
    return TomorrowWeather(
      temperature: json['temperature']?.toDouble() ?? 0,
      humidity: json['humidity']?.toDouble() ?? 0,
      windSpeed: json['windSpeed']?.toDouble() ?? 0,
      pressure: json['pressureSurfaceLevel']?.toDouble() ?? 0,
      uvIndex: json['uvIndex']?.toDouble() ?? 0,
      visibility: json['visibility']?.toDouble() ?? 0,
      weatherCode: json['weatherCode']?.toString() ?? '1000',
      time: DateTime.parse(json['time']),
      areaName: json['location']?['name']?.toString() ?? '',
      latitude: json['location']?['lat']?.toDouble() ?? 0,
      longitude: json['location']?['lon']?.toDouble() ?? 0,
    );
  }
} 