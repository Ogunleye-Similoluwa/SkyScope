class WeatherAlert {
  final String severity;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;

  WeatherAlert({
    required this.severity,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
  });

  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    return WeatherAlert(
      severity: json['severity'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      startTime: DateTime.parse(json['startTime'] ?? DateTime.now().toIso8601String()),
      endTime: DateTime.parse(json['endTime'] ?? DateTime.now().toIso8601String()),
    );
  }
} 