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
              SwitchListTile(
                title: const Text('Use Celsius'),
                subtitle: Text('Currently using: ${settings.useCelsius ? 'Celsius' : 'Fahrenheit'}'),
                value: settings.useCelsius,
                onChanged: (_) => context.read<SettingsCubit>().toggleTemperatureUnit(),
              ),
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
              SwitchListTile(
                title: const Text('Weather Notifications'),
                subtitle: const Text('Get notified about weather changes'),
                value: settings.showNotifications,
                onChanged: (_) => context.read<SettingsCubit>().toggleNotifications(),
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
}