import 'package:flutter/material.dart';
import '../models/weather_alert.dart';

class WeatherAlerts extends StatelessWidget {
  final List<WeatherAlert> alerts;

  const WeatherAlerts({
    Key? key,
    required this.alerts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.red.shade100,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return ListTile(
            leading: const Icon(Icons.warning, color: Colors.red),
            title: Text(alert.title),
            subtitle: Text(alert.description),
            trailing: Text(
              alert.severity,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
} 