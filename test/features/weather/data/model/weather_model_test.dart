import 'package:flutter_test/flutter_test.dart';
import 'package:weather_application/features/weather/data/model/weather_model.dart';

void main() {
  group('WeatherModel', () {
    test('should parse JSON correctly', () {
      final Map<String, dynamic> json = {
        'weather': [
          {'id': 1, 'main': 'Clear', 'description': 'Clear sky', 'icon': '01d'}
        ],
        'main': {'temp': 300, 'pressure': 1013, 'humidity': 50},
        'visibility': 10000,
        'wind': {'speed': 5, 'deg': 200},
        'clouds': {'all': 0},
        'dt': 1609459200,
        'dt_txt': '2021-01-01 00:00:00',
      };

      final weatherModel = WeatherModel.fromJson(json);

      expect(weatherModel.weather.length, 1);
      expect(weatherModel.weather[0].main, 'Clear');
      expect(weatherModel.main.temp, 300);
      expect(weatherModel.visibility, 10000);
      expect(weatherModel.wind.speed, 5);
      expect(weatherModel.clouds.all, 0);
      expect(weatherModel.dt, 1609459200);
      expect(weatherModel.dtStr, '2021-1-1');
      expect(weatherModel.dtAsDateTime, DateTime(2021, 1, 1, 0, 0, 0));
    });
  });
}
