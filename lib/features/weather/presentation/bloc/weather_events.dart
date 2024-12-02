import 'package:weather_application/core/utils/enums.dart';

abstract class WeatherEvent {}

class GetWeatherData extends WeatherEvent {
  final Cities city;

  GetWeatherData(this.city);
}
