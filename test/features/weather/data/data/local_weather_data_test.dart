import 'package:flutter_test/flutter_test.dart';
import 'package:weather_application/core/utils/enums.dart';
import 'package:weather_application/features/weather/data/data/local_weather_data.dart';

void main() {
  group('LocalWeatherData', () {
    test('should return the default temperature scale as metric', () {
      final localWeatherData = LocalWeatherData();

      expect(localWeatherData.temperatureScale, TemperatureScale.metric);
    });
  });
}