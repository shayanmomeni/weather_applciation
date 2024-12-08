import 'package:flutter_test/flutter_test.dart';
import 'package:weather_application/features/weather/data/model/weather_main_info_model.dart';

void main() {
  group('WeatherMainInfoModel', () {
    test('should create an instance with the correct values from JSON', () {
      final json = {
        'id': 800,
        'main': 'Clear',
        'description': 'Clear sky',
        'icon': '01d',
      };
      final weatherInfo = WeatherMainInfoModel.fromJson(json);

      expect(weatherInfo.id, 800);
      expect(weatherInfo.main, 'Clear');
      expect(weatherInfo.description, 'Clear sky');
      expect(weatherInfo.icon, '01d');
    });
  });
}