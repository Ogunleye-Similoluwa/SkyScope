// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simple_weather_application/bloc/weather_bloc_bloc.dart';
import '../reusables/background_gradient.dart';
import '../reusables/weather_card.dart';
import '../reusables//weather_header.dart';
import '../reusables//page_indicators.dart';
import '../reusables/weather_card.dart';
import '../screens/search_screen.dart';
import '../screens/detailed_forecast_screen.dart';
import '../screens/settings_screen.dart';
import '../widgets/expandable_fab.dart';

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
			),
			body: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
				builder: (context, state) {
					if (state is WeatherBlocSuccess) {
						return Stack(
							children: [
								const BackgroundGradient(),
								SafeArea(
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											WeatherHeader(
												areaName: state.currentWeather.areaName,
												onRefresh: () async {
													Position position = await Geolocator
															.getCurrentPosition();
													context.read<WeatherBlocBloc>().add(FetchWeather(
															position));
												},
											),
											Expanded(
												child: PageView.builder(
													controller: _pageController,
													onPageChanged: (int page) {
														setState(() => _currentPage = page);
														_animationController.forward(from: 0.0);
													},
													itemCount: 6,
													itemBuilder: (context, index) {
														final weathers = state.hourlyForecast;
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
											const SizedBox(height: 20),
										],
									),
								),
							],
						);
					} else if (state is WeatherBlocLoading) {
						return const Center(child: CircularProgressIndicator());
					} else {
						return const Center(child: Text('Something went wrong!'));
					}
				},
			),
			floatingActionButton: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
				builder: (context, state) {
					if (state is WeatherBlocSuccess) {
						return ExpandableFab(
							distance: 112.0,
							children: [
								ActionButton(
									onPressed: () async {
										final result = await Navigator.push(
											context,
											MaterialPageRoute(builder: (context) => SearchScreen()),
										);
										if (result != null) {
											context.read<WeatherBlocBloc>().add(
												FetchWeather(
													Position(
														latitude: result['lat'],
														longitude: result['lon'],
														timestamp: DateTime.now(),
														accuracy: 0,
														altitude: 0,
														heading: 0,
														speed: 0,
														speedAccuracy: 0,
														altitudeAccuracy: 0,
														headingAccuracy: 0,
													),
												),
											);
										}
									},
									icon: Icon(Icons.search),
								),
								ActionButton(
									onPressed: () {
										Navigator.push(
											context,
											MaterialPageRoute(
												builder: (context) => DetailedForecastScreen(
													hourlyForecast: state.hourlyForecast,
												),
											),
										);
									},
									icon: Icon(Icons.analytics),
								),
								ActionButton(
									onPressed: () {
										Navigator.push(
											context,
											MaterialPageRoute(builder: (context) => SettingsScreen()),
										);
									},
									icon: Icon(Icons.settings),
								),
							],
						);
					}
					return Container(); // Return empty container if state is not success
				},
			),
		);
	}
}