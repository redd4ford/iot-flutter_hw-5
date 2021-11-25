import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hw_5/bloc/theme_bloc.dart';
import 'package:hw_5/bloc/weather_bloc.dart';
import 'package:hw_5/events/theme_event.dart';
import 'package:hw_5/events/weather_event.dart';
import 'package:hw_5/states/theme_state.dart';
import 'package:hw_5/states/weather_state.dart';

import 'package:hw_5/widgets/search_button.dart';
import 'package:hw_5/widgets/temperature_widget.dart';
import 'package:hw_5/widgets/entry_tile.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Completer<void> _completer;
  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();
  }

  String _getLastUpdated(DateTime lastUpdated, BuildContext context) {
    return '${TimeOfDay.fromDateTime(lastUpdated).format(context)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
            listener: (context, weatherState) {
          if (weatherState is WeatherStateSuccess) {
            BlocProvider.of<ThemeBloc>(context).add(ThemeEventWeatherChanged(
                weatherCondition: weatherState.weather.weatherCondition));
            _completer?.complete();
            _completer = Completer();
          }
        }, builder: (context, weatherState) {
          if (weatherState is WeatherStateLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (weatherState is WeatherStateSuccess) {
            final weather = weatherState.weather;

            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
                return RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(WeatherEventRefresh(city: weather.location));
                    return _completer.future;
                  },
                  child: Container(
                    color: themeState.backgroundColor,
                    child: ListView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 5),
                              child: Text(
                                'Last Update: ${_getLastUpdated(weather.lastUpdated, context)}',
                                style: TextStyle(
                                    fontSize: 16, color: themeState.textColor),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                weather.location,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: themeState.textColor),
                              ),
                            ),
                            TemperatureWidget(
                              weather: weather,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (weatherState is WeatherStateFailure) {
            return Text(
              'Something must be wrong, it\'s not me, it\'s you',
              style: TextStyle(color: Colors.redAccent, fontSize: 18),
            );
          }
          return EntryTile();
        }),
      ),
      floatingActionButton: SearchButton(),
    );
  }
}
