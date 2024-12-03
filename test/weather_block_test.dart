import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_application/core/models/remote_data_model.dart';
import 'package:weather_application/core/utils/enums.dart';
import 'package:weather_application/core/utils/extentions.dart';
import 'package:weather_application/features/weather/data/data/local_weather_data.dart';
import 'package:weather_application/features/weather/data/model/weather_model.dart';
import 'package:weather_application/features/weather/domain/repo/weather_repo.dart';
import 'package:weather_application/features/weather/presentation/bloc/weather_block.dart';
import 'package:weather_application/features/weather/presentation/bloc/weather_events.dart';
import 'package:weather_application/features/weather/presentation/bloc/weather_states.dart';

import 'mock_weather_data.dart';

class MockWeatherRepository extends Mock implements WeatherDataRepository {}

class MockWeatherLocalDatasource extends Mock implements LocalWeatherData {}

void main() {
  late WeatherBloc weatherBloc;
  late MockWeatherRepository mockWeatherRepository;
  late MockWeatherLocalDatasource mockLocalDatasource;
  late List<WeatherModel> tWeatherData;

  setUpAll(() {
    registerFallbackValue(TemperatureScale.metric);
  });

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    mockLocalDatasource = MockWeatherLocalDatasource();
    tWeatherData = MockWeatherData.weatherList;

    when(() => mockLocalDatasource.temperatureScale)
        .thenReturn(TemperatureScale.metric);

    when(() => mockWeatherRepository.fetchWeatherData(
          any<String>(),
          tempretureUnit: any<TemperatureScale>(named: 'tempretureUnit'),
        )).thenAnswer((_) async => Right(tWeatherData));

    weatherBloc = WeatherBloc(mockWeatherRepository);
  });

  tearDown(() {
    weatherBloc.close();
  });

  group('WeatherBloc', () {
    test('initial state should be WeatherInitial', () {
      weatherBloc = WeatherBloc(mockWeatherRepository);
      expect(weatherBloc.state, isA<WeatherInitial>());
    });

    test('should fetch data for first city on initialization', () async {
      weatherBloc = WeatherBloc(mockWeatherRepository);
      await Future.delayed(Duration.zero);
      verify(() => mockWeatherRepository.fetchWeatherData(
            Cities.values.first.toStr,
            tempretureUnit: any<TemperatureScale>(named: 'tempretureUnit'),
          )).called(2);

      expect(weatherBloc.state, isA<WeatherLoaded>());
    });

    blocTest<WeatherBloc, WeatherState>(
      'should emit WeatherLoaded when GetWeatherData is added',
      build: () => weatherBloc,
      act: (bloc) => bloc.add(GetWeatherData(Cities.values.first)),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(MockWeatherData.weatherList),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'should emit WeatherError when GetWeatherData is added and error occures',
      build: () {
        when(() => mockWeatherRepository.fetchWeatherData(
                  any<String>(),
                  tempretureUnit:
                      any<TemperatureScale>(named: 'tempretureUnit'),
                ))
            .thenAnswer(
                (_) async => Left(RemoteDataFailModel(message: 'error')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherData(Cities.values.first)),
      expect: () => [
        WeatherLoading(),
        WeatherError('error'),
      ],
    );
  });
}
