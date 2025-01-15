// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_weather_application/bloc/weather_bloc_bloc.dart';
import 'package:simple_weather_application/reusables/weather_drawer.dart';
import '../reusables/background_gradient.dart';
import '../reusables/weather_card.dart';
import '../reusables//weather_header.dart';
import '../reusables//page_indicators.dart';
import '../reusables/weather_card.dart';
import '../reusables/weather_alerts.dart';
import '../reusables/hourly_forecast.dart';
import '../reusables/weather_details.dart';
import '../reusables/weather_map.dart';
import 'package:share_plus/share_plus.dart';
import '../models/tomorrow_weather.dart';

class HomeScreen extends StatefulWidget {
	const HomeScreen({super.key});

	@override
	State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
	late PageController _pageController;
	late AnimationController _animationController;
	int _currentPage = 0;

	@override
	void initState() {
		super.initState();
		_pageController = PageController(initialPage: 0);
		_animationController = AnimationController(
			vsync: this,
			duration: const Duration(milliseconds: 500),
		);
		
		_initializeWeather();
	}

	Future<void> _initializeWeather() async {
		try {
			final position = await Geolocator.getCurrentPosition();
			if (mounted) {
				context.read<WeatherBlocBloc>().add(FetchWeather(position));
			}
		} catch (e) {
			print('Error initializing weather: $e');
		}
	}

	@override
	void dispose() {
		_pageController.dispose();
		_animationController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.black,
			extendBodyBehindAppBar: true,
			appBar: AppBar(
				backgroundColor: Colors.transparent,
				elevation: 0,
				systemOverlayStyle: const SystemUiOverlayStyle(
						statusBarBrightness: Brightness.dark
				),
				actions: [
					IconButton(
						icon: const Icon(Icons.search),
						onPressed: () => _showSearchLocationDialog(context),
					),
					IconButton(
						icon: const Icon(Icons.settings),
						onPressed: () => Navigator.pushNamed(context, '/settings'),
					),
				],
			),
			drawer: WeatherDrawer(),
			body: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
				builder: (context, state) {
					if (state is WeatherBlocSuccess) {
						return Stack(
							children: [
								const BackgroundGradient(),
								SafeArea(
									child: RefreshIndicator(
										onRefresh: () async {
											Position position = await Geolocator.getCurrentPosition();
											context.read<WeatherBlocBloc>().add(FetchWeather(position));
										},
										child: CustomScrollView(
											slivers: [
												SliverToBoxAdapter(
													child: Column(
														children: [
															WeatherHeader(
																areaName: state.currentWeather.areaName!,
																onRefresh: () async {
																	Position position = await Geolocator.getCurrentPosition();
																	context.read<WeatherBlocBloc>().add(FetchWeather(position));
																},
															),
															WeatherAlerts(alerts: state.weatherAlerts),
															HourlyForecast(hourlyData: state.hourlyForecast),
															WeatherDetails(
																humidity: state.currentWeather.humidity ?? 0,
																windSpeed: state.currentWeather.windSpeed ?? 0,
																pressure: state.currentWeather.pressure ?? 0,
																uvIndex: 0,
																visibility: 10000,
															),
														],
													),
												),
												SliverFillRemaining(
													child: Column(
														children: [
															Expanded(
																child: PageView.builder(
																	controller: _pageController,
																	onPageChanged: (int page) {
																		setState(() => _currentPage = page);
																		_animationController.forward(from: 0.0);
																	},
																	itemCount: 6,
																	itemBuilder: (context, index) {
																		final weathers = state.forecast;
																		final currentWeather = index == 0 ? state
																				.currentWeather : weathers[index];
																		return WeatherCard(
																				weather: currentWeather,
																				isCurrentDay: index == 0,
																				index: index,
																				animationController: _animationController,
																		);
																	},
																),
															),
															PageIndicators(currentPage: _currentPage),
															WeatherMap(
																location: LatLng(
																	state.currentWeather.latitude ?? 0,
																	state.currentWeather.longitude ?? 0,
																),
															),
														],
													),
												),
											],
										),
									),
								),
							],
						);
					} else if (state is WeatherBlocLoading) {
						return const Center(child: CircularProgressIndicator());
					} else if (state is WeatherBlocError) {
						return Center(
							child: Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Text(
										'Error: ${state.message}',
										style: const TextStyle(color: Colors.white),
										textAlign: TextAlign.center,
									),
									const SizedBox(height: 16),
									ElevatedButton(
										onPressed: () async {
											final position = await Geolocator.getCurrentPosition();
											context.read<WeatherBlocBloc>().add(FetchWeather(position));
										},
										child: const Text('Retry'),
									),
								],
							),
						);
					} else {
						return const Center(child: Text('Initial State'));
					}
				},
			),
			floatingActionButton: FloatingActionButton(
				onPressed: () => _showWeatherShareSheet(context),
				child: const Icon(Icons.share),
			),
		);
	}

	void _showSearchLocationDialog(BuildContext context) {
		showDialog(
			context: context,
			builder: (context) => AlertDialog(
				title: const Text('Search Location'),
				content: TextField(
					decoration: const InputDecoration(
						hintText: 'Enter city name',
						prefixIcon: Icon(Icons.search),
					),
					onSubmitted: (value) {
						context.read<WeatherBlocBloc>().add(SearchLocation(value));
						Navigator.pop(context);
					},
				),
			),
		);
	}

	void _showWeatherShareSheet(BuildContext context) {
		final state = context.read<WeatherBlocBloc>().state;
		if (state is WeatherBlocSuccess) {
			final weather = state.currentWeather;
			final shareText = 'Weather in ${weather.areaName}: '
				'${weather.temperature.toStringAsFixed(1)}°C, '
				'${weather.weatherCode}';
			Share.share(shareText);
		}
	}
}