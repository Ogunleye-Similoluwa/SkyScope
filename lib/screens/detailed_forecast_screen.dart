import 'package:flutter/material.dart';
import '../models/tomorrow_weather.dart';
import 'package:fl_chart/fl_chart.dart';

class DetailedForecastScreen extends StatelessWidget {
  final List<TomorrowWeather> hourlyForecast;

  const DetailedForecastScreen({required this.hourlyForecast});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Detailed Forecast'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildChartSection(
                title: 'Temperature (°C)',
                color: Colors.orange,
                data: hourlyForecast.map((w) => w.temperature).toList(),
                icon: Icons.thermostat,
              ),
              _buildChartSection(
                title: 'Precipitation Probability (%)',
                color: Colors.blue,
                data: hourlyForecast.map((w) => w.precipitation).toList(),
                icon: Icons.water_drop,
              ),
              _buildChartSection(
                title: 'Wind Speed (km/h)',
                color: Colors.green,
                data: hourlyForecast.map((w) => w.windSpeed).toList(),
                icon: Icons.air,
              ),
              _buildChartSection(
                title: 'UV Index',
                color: Colors.purple,
                data: hourlyForecast.map((w) => w.uvIndex).toList(),
                icon: Icons.wb_sunny,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartSection({
    required String title,
    required Color color,
    required List<double> data,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: color),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.white24,
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= 0 && value.toInt() < hourlyForecast.length) {
                        return Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            '${hourlyForecast[value.toInt()].time.hour}:00',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        );
                      }
                      return Text('');
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toStringAsFixed(0),
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: data.asMap().entries.map((entry) {
                    return FlSpot(entry.key.toDouble(), entry.value);
                  }).toList(),
                  isCurved: true,
                  color: color,
                  barWidth: 3,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: color.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
} 