import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:weather_application/core/models/error_response_model.dart';
import 'package:weather_application/core/models/remote_data_model.dart';
import 'package:weather_application/core/utils/enums.dart';
import 'package:weather_application/features/weather/data/data/remote_weather_data.dart';
import 'package:weather_application/features/weather/data/model/weather_model.dart';
import 'package:weather_application/features/weather/data/repo/weather_repo_impl.dart';

class MockRemoteWeatherDatasource extends Mock
    implements RemoteWeatherDatasource {}

void main() {
  late MockRemoteWeatherDatasource mockRemoteWeatherDatasource;
  late WeatherRepositoryImpl weatherRepository;

  setUp(() {
    mockRemoteWeatherDatasource = MockRemoteWeatherDatasource();
    weatherRepository =
        WeatherRepositoryImpl(remote: mockRemoteWeatherDatasource);
  });

  group('WeatherRepositoryImpl', () {
    test('should return weather data when the data is successfully fetched',
        () async {
      final mockWeatherData = {
        'list': [
          {
            'weather': [
              {
                'id': 1,
                'main': 'Clear',
                'description': 'Clear sky',
                'icon': '01d'
              }
            ],
            'main': {'temp': 300.15, 'pressure': 1015, 'humidity': 80},
            'visibility': 10000,
            'wind': {'speed': 3.6, 'deg': 180},
            'clouds': {'all': 0},
            'dt': 1609459200,
            'dt_txt': '2021-01-01 00:00:00'
          },
        ]
      };

      // Mock the Response object to return mockWeatherData
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        data: mockWeatherData,
        statusCode: 200,
      );

      // Mocking the remote datasource to return the mock Response
      when(() => mockRemoteWeatherDatasource.fetchWeather(any()))
          .thenAnswer((_) async => mockResponse);

      // Call the repository method
      final result = await weatherRepository.fetchWeatherData('London',
          tempretureUnit: TemperatureScale.metric);

      expect(result.isRight(), true);
      final weatherList = result.getOrElse(() => []);
      expect(weatherList, isA<List<WeatherModel>>());
      expect(weatherList[0].weather.first.main, 'Clear');
    });

    test('should return a failure when an error is thrown by remote datasource',
        () async {
      when(() => mockRemoteWeatherDatasource.fetchWeather(any())).thenThrow(
          ErrorResponseModel(message: 'Failed to fetch weather data'));

      final result = await weatherRepository.fetchWeatherData('London',
          tempretureUnit: TemperatureScale.metric);

      expect(result.isLeft(), true);
      final failure =
          result.swap().getOrElse(() => RemoteDataFailModel(message: ''));
      expect(failure.message, 'Failed to fetch weather data');
    });
  });
}
