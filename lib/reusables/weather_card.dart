import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:simple_weather_application/models/tomorrow_weather.dart';
import 'package:simple_weather_application/reusables/weather_chart.dart';
import 'package:weather/weather.dart';
import 'weather_card_content.dart';

class WeatherCard extends StatelessWidget {
  final TomorrowWeather weather;
  final bool isCurrentDay;
  final int index;
  final AnimationController animationController;

  const WeatherCard({
    Key? key,
    required this.weather,
    required this.isCurrentDay,
    required this.index,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                ),
                child:
                WeatherCardContent(
                  weather: weather,
                  isCurrentDay: isCurrentDay,
                  index: index,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}