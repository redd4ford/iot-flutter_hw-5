import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_icons/weather_icons.dart';

import 'package:hw_5/bloc/theme_bloc.dart';
import 'package:hw_5/states/theme_state.dart';

import 'package:hw_5/data/weather.dart';
import 'package:hw_5/data/weather_condition.dart';

import 'package:hw_5/widgets/weather_tile.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;

  TemperatureWidget({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  IconData weatherToIcon({WeatherCondition weatherCondition}) {
    if (weatherCondition == WeatherCondition.clear ||
        weatherCondition == WeatherCondition.lightCloud) {
      return WeatherIcons.day_sunny;
    } else if (weatherCondition == WeatherCondition.hail ||
        weatherCondition == WeatherCondition.snow ||
        weatherCondition == WeatherCondition.sleet) {
      return WeatherIcons.snow;
    } else if (weatherCondition == WeatherCondition.heavyCloud) {
      return WeatherIcons.cloud_up;
    } else if (weatherCondition == WeatherCondition.heavyRain ||
        weatherCondition == WeatherCondition.lightRain ||
        weatherCondition == WeatherCondition.showers) {
      return WeatherIcons.rain;
      ;
    } else if (weatherCondition == WeatherCondition.thunderstorm) {
      return WeatherIcons.thunderstorm;
    } else if (weatherCondition == WeatherCondition.unknown) {
      return WeatherIcons.alien;
    } else {
      return WeatherIcons.sunset;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BoxedIcon(
              weatherToIcon(weatherCondition: weather.weatherCondition),
              size: 32,
              color: _themeState.textColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  WeatherTile(type: 'Min', value: weather.minTemp.round()),
                  WeatherTile(type: 'Avg', value: weather.temp.round()),
                  WeatherTile(type: 'Max', value: weather.maxTemp.round()),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
