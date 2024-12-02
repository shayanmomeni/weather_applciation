import 'package:weather_application/core/utils/enums.dart';

class LocalWeatherData {
  static final LocalWeatherData _singleton = LocalWeatherData._internal();
  factory LocalWeatherData() => _singleton;
  LocalWeatherData._internal();

  TemperatureScale temperatureScale = TemperatureScale.metric;
}
