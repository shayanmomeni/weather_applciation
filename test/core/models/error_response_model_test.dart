import 'package:flutter_test/flutter_test.dart';
import 'package:weather_application/core/models/error_response_model.dart';

void main() {
  group('ErrorResponseModel', () {
    test('should create an instance with the given message', () {
      const message = 'An error occurred';
      final errorResponse = ErrorResponseModel(message: message);

      expect(errorResponse.message, message);
    });
  });
}
