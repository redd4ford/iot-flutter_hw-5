import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hw_5/events/weather_event.dart';
import 'package:hw_5/states/weather_state.dart';
import 'package:hw_5/repo/weather_repo.dart';

import 'package:hw_5/data/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepo;

  WeatherBloc({@required this.weatherRepo})
      : assert(weatherRepo != null),
        super(WeatherStateInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
    if (weatherEvent is WeatherEventRequested) {
      yield WeatherStateLoading();
      try {
        final Weather weather =
            await weatherRepo.getWeatherByCity(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    } else if (weatherEvent is WeatherEventRefresh) {
      try {
        final Weather weather =
            await weatherRepo.getWeatherByCity(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    }
  }
}
