import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:hw_5/data/weather.dart';

const _apiUrl = 'https://www.metaweather.com';
final _locationUrl = (city) => '${_apiUrl}/api/location/search/?query=${city}';
final _weatherUrl = (locationId) => '${_apiUrl}/api/location/${locationId}';

final http.Client httpClient = new http.Client();

class WeatherRepository {
  WeatherRepository();
  Future<int> getLocationIdByCity(String city) async {
    final response = await httpClient.get(_locationUrl(city));
    if (response.statusCode == 200) {
      final cities = jsonDecode(response.body) as List;
      return (cities.first)['woeid'] ?? Map();
    } else {
      throw Exception('An error occurred for city=${city}');
    }
  }

  Future<Weather> getWeatherByCity(String city) async {
    final int locationId = await getLocationIdByCity(city);

    final response = await httpClient.get(_weatherUrl(locationId));
    if (response.statusCode != 200) {
      throw Exception('An error occurred for locationId=${locationId}');
    }
    final weatherJson = jsonDecode(response.body);
    return Weather.fromJson(weatherJson);
  }
}
