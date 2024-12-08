import 'package:flutter_test/flutter_test.dart';
import 'package:weather_application/features/weather/data/model/clouds_model.dart';

void main() {
  group('CloudsModel', () {
    test('should create an instance with the correct values from JSON', () {
      final json = {'all': 75};
      final clouds = CloudsModel.fromJson(json);

      expect(clouds.all, 75);
    });

    test('should create an empty instance with default values', () {
      final clouds = CloudsModel.empty();

      expect(clouds.all, 0);
    });
  });
}
