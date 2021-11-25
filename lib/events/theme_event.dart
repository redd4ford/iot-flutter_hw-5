import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'package:hw_5/data/weather_condition.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeEventWeatherChanged extends ThemeEvent {
  final WeatherCondition weatherCondition;
  const ThemeEventWeatherChanged({@required this.weatherCondition})
      : assert(weatherCondition != null);
  @override
  List<Object> get props => [weatherCondition];
}
