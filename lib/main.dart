import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather_application/bloc/weather_bloc_bloc.dart';
import 'package:simple_weather_application/screens/home_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather_application/services/weather_service.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");
  final apiKey = dotenv.env['WEATHER_API_KEY'] ?? '';
  print('API Key: $apiKey');
  
  final prefs = await SharedPreferences.getInstance();
  final weatherService = WeatherService(apiKey);

  runApp(MyApp(
    prefs: prefs,
    weatherService: weatherService,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final WeatherService weatherService;

  const MyApp({
    super.key,
    required this.prefs,
    required this.weatherService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBlocBloc(
            weatherService: weatherService,
            prefs: prefs,
          ),
        ),
        // ... other providers
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: _determinePosition(),
          builder: (context, snap) {
            if(snap.hasData) {
              return const HomeScreen();
            } else {
              return const Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
        )
      ),
    );
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  return await Geolocator.getCurrentPosition();
}
