import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hw_5/bloc/theme_bloc.dart';
import 'package:hw_5/states/theme_state.dart';

class WeatherTile extends StatelessWidget {
  final String type;
  final int value;

  WeatherTile({Key key, @required this.type, @required this.value})
      : assert(type != null, value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;

    return Text(
      '${this.type}: ${this.value.round()} °C',
      style: TextStyle(
        fontSize: 18,
        color: _themeState.textColor,
      ),
    );
  }
}
