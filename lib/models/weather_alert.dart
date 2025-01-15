class WeatherAlert {
  final String title;
  final String description;
  final String severity;
  
  const WeatherAlert({
    required this.title,
    required this.description,
    required this.severity,
  });

  WeatherAlert copyWith({
    String? title,
    String? description,
    String? severity,
  }) {
    return WeatherAlert(
      title: title ?? this.title,
      description: description ?? this.description,
      severity: severity ?? this.severity,
    );
  }
} 