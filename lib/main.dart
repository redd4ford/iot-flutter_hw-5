import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hw_5/bloc/theme_bloc.dart';
import 'package:hw_5/bloc/weather_bloc.dart';
import 'package:hw_5/bloc/weather_bloc_observer.dart';
import 'package:hw_5/repo/weather_repo.dart';
import 'package:hw_5/screens/weather_screen.dart';
import 'package:hw_5/states/theme_state.dart';

void main() {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepository weatherRepo = WeatherRepository();
  runApp(BlocProvider<ThemeBloc>(
    create: (context) => ThemeBloc(),
    child: MyApp(
      weatherRepo: weatherRepo,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepo;
  MyApp({Key key, @required this.weatherRepo})
      : assert(weatherRepo != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
            title: 'Weather App',
            home: BlocProvider(
              create: (context) => WeatherBloc(weatherRepo: weatherRepo),
              child: WeatherPage(),
            ));
      },
    );
  }
}
