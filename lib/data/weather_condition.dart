enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

WeatherCondition mapAbbrToWeather(String weatherStateAbbr) {
  Map<String, WeatherCondition> map = {
    'sn': WeatherCondition.snow,
    'sl': WeatherCondition.sleet,
    'h': WeatherCondition.hail,
    't': WeatherCondition.thunderstorm,
    'hr': WeatherCondition.heavyRain,
    'lr': WeatherCondition.lightRain,
    's': WeatherCondition.showers,
    'hc': WeatherCondition.heavyCloud,
    'lc': WeatherCondition.lightCloud,
    'c': WeatherCondition.clear
  };
  return map[weatherStateAbbr] ?? WeatherCondition.unknown;
}
