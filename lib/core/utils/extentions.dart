import 'package:intl/intl.dart';
import 'package:weather_application/core/constants/config.dart';
import 'package:weather_application/core/utils/enums.dart';

extension TemperatureScaleExtension on TemperatureScale {
  String get unitSymbol => this == TemperatureScale.metric ? '°C' : '°F';
  String get toStr => this == TemperatureScale.metric ? 'metric' : 'imperial';
}

extension TemperatureScaleStrExtension on String {
  TemperatureScale get toTemperatureScale =>
      this == 'imperial' ? TemperatureScale.imperial : TemperatureScale.metric;
}

extension CitiesExtension on Cities {
  String get toStr {
    switch (this) {
      case Cities.heilbronn:
        return 'Heilbronn';
      case Cities.berlin:
        return 'Berlin';
      case Cities.paris:
        return 'Paris';
      case Cities.london:
        return 'London';
      case Cities.newyork:
        return 'New York';
      default:
        return '';
    }
  }
}

extension DateTimeExtension on DateTime {
  String get nameStr {
    String dayName = DateFormat('EEEE').format(this);
    return dayName;
  }

  String get nameAbbrStr {
    String dayName = DateFormat('EEE').format(this);
    return dayName;
  }
}

extension DateTimeIntExtension on int {
  DateTime get convertToDateTime =>
      DateTime.fromMillisecondsSinceEpoch((this * 1000), isUtc: true);
}

extension WeatherIconUrlExtension on String {
  String get toWeatherIconUrl => '${AppConfig().constant.iconUrl}/$this@4x.png';
}
