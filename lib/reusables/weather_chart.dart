import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:fl_chart/fl_chart.dart';

class WeatherChart extends StatelessWidget {
  final List<Weather> hourlyForecast;

  const WeatherChart({Key? key, required this.hourlyForecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < hourlyForecast.length) {
                    return Text(
                      '${hourlyForecast[value.toInt()].date!.hour}:00',
                      style: const TextStyle(color: Colors.white70),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: hourlyForecast.asMap().entries.map((entry) {
                return FlSpot(entry.key.toDouble(), entry.value.temperature!.celsius!);
              }).toList(),
              isCurved: true,
              color: Colors.white,
              barWidth: 2,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}