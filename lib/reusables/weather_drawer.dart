import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc_bloc.dart';

class WeatherDrawer extends StatelessWidget {
  const WeatherDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saved Locations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
            builder: (context, state) {
              if (state is WeatherBlocSuccess) {
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(state.currentWeather.areaName ?? ''),
                      subtitle: Text('Current Location'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
} 