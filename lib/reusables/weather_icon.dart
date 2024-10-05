import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final int code;

  const WeatherIcon({
    Key? key,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: _getWeatherIcon(code),
    );
  }

  Widget _getWeatherIcon(int code) {
    String assetPath;

    if (code >= 200 && code < 300) {
      assetPath = 'assets/1.png';
    } else if (code >= 300 && code < 400) {
      assetPath = 'assets/2.png';
    } else if (code >= 500 && code < 600) {
      assetPath = 'assets/3.png';
    } else if (code >= 600 && code < 700) {
      assetPath = 'assets/4.png';
    } else if (code >= 700 && code < 800) {
      assetPath = 'assets/5.png';
    } else if (code == 800) {
      assetPath = 'assets/6.png';
    } else {
      assetPath = 'assets/7.png';
    }

    return Image.asset(
      assetPath,
      fit: BoxFit.scaleDown,
    );
  }
}