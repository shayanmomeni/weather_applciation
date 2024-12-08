import 'package:flutter_test/flutter_test.dart';
import 'package:weather_application/features/weather/data/model/wind_model.dart';

void main() {
  group('WindModel', () {
    test('should create an instance with the correct values from JSON', () {
      final json = {
        'speed': 5.6,
        'deg': 180,
      };

      final windModel = WindModel.fromJson(json);

      expect(windModel.speed, 5.6);
      expect(windModel.deg, 180);
    });

    test('should handle integer speed values correctly', () {
      final json = {
        'speed': 10, // An integer value
        'deg': 90,
      };

      final windModel = WindModel.fromJson(json);

      expect(windModel.speed, 10.0); // Make sure it converts to double
      expect(windModel.deg, 90);
    });

    test('should create an empty instance with default values', () {
      final windModel = WindModel.empty();

      expect(windModel.speed, 0);
      expect(windModel.deg, 0);
    });
  });
}
