import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_application/features/weather/data/data/remote_weather_data.dart';
import 'package:weather_application/core/models/error_response_model.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDatasource extends Mock implements RemoteWeatherDatasource {}

void main() {
  group('RemoteWeatherDatasource', () {
    late RemoteWeatherDatasource remoteWeatherDatasource;

    setUp(() {
      remoteWeatherDatasource = MockRemoteDatasource();
    });

    test('fetchWeather should return a valid response', () async {
      final response = Response(
        data: {'weather': 'sunny'},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(() => remoteWeatherDatasource.fetchWeather(any()))
          .thenAnswer((_) async => response);

      final result =
          await remoteWeatherDatasource.fetchWeather({'q': 'London'});

      expect(result.statusCode, 200);
      expect(result.data['weather'], 'sunny');
    });

    test('fetchWeather should throw error if an exception occurs', () async {
      when(() => remoteWeatherDatasource.fetchWeather(any()))
          .thenThrow(ErrorResponseModel(message: 'Error fetching weather'));

      try {
        await remoteWeatherDatasource.fetchWeather({'q': 'London'});
      } catch (e) {
        expect(e, isInstanceOf<ErrorResponseModel>());
        expect((e as ErrorResponseModel).message, 'Error fetching weather');
      }
    });
  });
}
