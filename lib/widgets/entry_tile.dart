import 'package:flutter/material.dart';

class EntryTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Weather App',
              style: TextStyle(fontSize: 32),
            ),
            Text(
              'another one weather app',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Text(
          'Press the 🔎 button to start.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
