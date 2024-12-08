import 'package:flutter_test/flutter_test.dart';
import 'package:weather_application/core/models/remote_data_model.dart';

void main() {
  group('RemoteDataFailModel', () {
    test('should have default message when no message is passed', () {
      final model = RemoteDataFailModel();

      expect(model.message, 'Something went wrong! Please try again later.');
    });

    test('should accept a custom message', () {
      final customMessage = 'Custom error message';
      final model = RemoteDataFailModel(message: customMessage);

      expect(model.message, customMessage);
    });
  });
}
