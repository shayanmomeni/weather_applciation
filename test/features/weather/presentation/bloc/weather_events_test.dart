import 'package:flutter_test/flutter_test.dart';
import 'package:weather_application/core/utils/enums.dart';
import 'package:weather_application/features/weather/presentation/bloc/weather_events.dart';

void main() {
  group('WeatherEvent', () {
    test('GetWeatherData should be a subclass of WeatherEvent', () {
      expect(GetWeatherData(Cities.newyork), isA<WeatherEvent>());
    });

    test('GetWeatherData should have a city property', () {
      final event = GetWeatherData(Cities.london);
      expect(event.city, Cities.london);
    });
  });
}
