import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WeatherMap extends StatelessWidget {
  final LatLng location;

  const WeatherMap({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: location,
            zoom: 12,
          ),
          markers: {
            Marker(
              markerId: const MarkerId('current_location'),
              position: location,
            ),
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
        ),
      ),
    );
  }
} 