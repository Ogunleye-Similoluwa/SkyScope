import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/setting_cubit.dart';
import '../reusables/setting_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsModel>(
      builder: (context, settings) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: ListView(
            children: [
              _buildSection(
                title: 'Units',
                children: [
                  SwitchListTile(
                    title: const Text('Use Celsius'),
                    subtitle: Text('Currently using: ${settings.useCelsius ? 'Celsius' : 'Fahrenheit'}'),
                    value: settings.useCelsius,
                    onChanged: (_) => context.read<SettingsCubit>().toggleTemperatureUnit(),
                  ),
                  SwitchListTile(
                    title: const Text('Use Metric System'),
                    subtitle: const Text('For wind speed and visibility'),
                    value: settings.useMetric,
                    onChanged: (_) => context.read<SettingsCubit>().toggleMetricSystem(),
                  ),
                ],
              ),
              _buildSection(
                title: 'Appearance',
                children: [
                  ListTile(
                    title: const Text('Theme'),
                    subtitle: Text('Current theme: ${settings.themeMode}'),
                    trailing: DropdownButton<String>(
                      value: settings.themeMode,
                      items: ['system', 'light', 'dark'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          context.read<SettingsCubit>().setThemeMode(newValue);
                        }
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Color Scheme'),
                    subtitle: Text('Current scheme: ${settings.colorScheme}'),
                    trailing: DropdownButton<String>(
                      value: settings.colorScheme,
                      items: ['default', 'nature', 'ocean', 'sunset']
                          .map((String value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.toUpperCase()),
                              ))
                          .toList(),
                      onChanged: (value) => context.read<SettingsCubit>().setColorScheme(value!),
                    ),
                  ),
                ],
              ),
              _buildSection(
                title: 'Notifications',
                children: [
                  SwitchListTile(
                    title: const Text('Weather Notifications'),
                    subtitle: const Text('Get notified about weather changes'),
                    value: settings.showNotifications,
                    onChanged: (_) => context.read<SettingsCubit>().toggleNotifications(),
                  ),
                  SwitchListTile(
                    title: const Text('Severe Weather Alerts'),
                    value: settings.severeWeatherAlerts,
                    onChanged: (_) => context.read<SettingsCubit>().toggleSevereWeatherAlerts(),
                  ),
                  SwitchListTile(
                    title: const Text('Daily Forecast Notification'),
                    value: settings.dailyForecastNotification,
                    onChanged: (_) => context.read<SettingsCubit>().toggleDailyForecast(),
                  ),
                ],
              ),
              ListTile(
                title: const Text('Refresh Interval'),
                subtitle: Text('Current interval: ${settings.refreshInterval} minutes'),
                trailing: DropdownButton<int>(
                  value: settings.refreshInterval,
                  items: [15, 30, 60, 120].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value min'),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      context.read<SettingsCubit>().setRefreshInterval(newValue);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }
}