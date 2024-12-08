import 'package:flutter_test/flutter_test.dart';
import 'package:weather_application/features/weather/data/model/weather_model.dart';
import 'package:weather_application/features/weather/presentation/bloc/weather_states.dart';

void main() {
  group('WeatherState', () {
    test('WeatherInitial supports value comparison', () {
      expect(WeatherInitial(), WeatherInitial());
    });

    test('WeatherLoading supports value comparison', () {
      expect(WeatherLoading(), WeatherLoading());
    });

    test('WeatherLoaded supports value comparison', () {
      final weatherData = [WeatherModel.empty()];
      final weatherLoadedState = WeatherLoaded(weatherData);

      expect(weatherLoadedState.props, [weatherData]);
    });

    test('WeatherLoaded props are correct', () {
      final weatherData = [WeatherModel.empty()];
      final weatherLoadedState = WeatherLoaded(weatherData);

      expect(weatherLoadedState.props, [weatherData]);
    });

    test('WeatherError supports value comparison', () {
      final errorMessage = 'Error message';
      final weatherErrorState = WeatherError(errorMessage);

      // Check if the states have the same error message
      expect(weatherErrorState, WeatherError(errorMessage));
    });

    test('WeatherError props are correct', () {
      final errorMessage = 'Error message';
      final weatherErrorState = WeatherError(errorMessage);

      expect(weatherErrorState.props, [errorMessage]);
    });
  });
}
