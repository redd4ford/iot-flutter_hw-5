import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hw_5/bloc/theme_bloc.dart';
import 'package:hw_5/bloc/weather_bloc.dart';
import 'package:hw_5/events/theme_event.dart';
import 'package:hw_5/events/weather_event.dart';
import 'package:hw_5/states/theme_state.dart';
import 'package:hw_5/states/weather_state.dart';

import 'package:hw_5/screens/search_screen.dart';

import 'package:hw_5/bloc/theme_bloc.dart';
import 'package:hw_5/states/theme_state.dart';

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;

    return FloatingActionButton(
      onPressed: () async {
        final typedCity = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(),
          ),
        );
        if (typedCity != null) {
          BlocProvider.of<WeatherBloc>(context)
              .add(WeatherEventRequested(city: typedCity));
        }
      },
      child: const Icon(Icons.search),
      backgroundColor: _themeState.textColor,
      foregroundColor: _themeState.backgroundColor,
    );
  }
}
