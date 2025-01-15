import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/setting_cubit.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Settings'),
      ),
      body: BlocBuilder<SettingsCubit, SettingsModel>(
        builder: (context, settings) {
          return ListView(
            children: [
              _buildSection(
                title: 'Units',
                children: [
                  SwitchListTile(
                    title: Text('Use Celsius', style: TextStyle(color: Colors.white)),
                    value: settings.useCelsius,
                    onChanged: (value) => context.read<SettingsCubit>().toggleTemperatureUnit(),
                  ),
                  SwitchListTile(
                    title: Text('Use 24-hour format', style: TextStyle(color: Colors.white)),
                    value: settings.use24HourFormat,
                    onChanged: (value) => context.read<SettingsCubit>().toggleTimeFormat(),
                  ),
                ],
              ),
              _buildSection(
                title: 'Notifications',
                children: [
                  SwitchListTile(
                    title: Text('Weather Alerts', style: TextStyle(color: Colors.white)),
                    value: settings.enableNotifications,
                    onChanged: (value) => context.read<SettingsCubit>().toggleNotifications(),
                  ),
                  SwitchListTile(
                    title: Text('Daily Forecast', style: TextStyle(color: Colors.white)),
                    value: settings.enableDailyForecast,
                    onChanged: (value) => context.read<SettingsCubit>().toggleDailyForecast(),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        Divider(color: Colors.white24),
      ],
    );
  }
}