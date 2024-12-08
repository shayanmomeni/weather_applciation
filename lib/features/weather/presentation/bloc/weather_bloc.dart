import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/core/utils/enums.dart';
import 'package:weather_application/core/utils/extentions.dart';
import 'package:weather_application/features/weather/data/data/local_weather_data.dart';
import 'package:weather_application/features/weather/domain/repo/weather_repo.dart';

import 'weather_events.dart';
import 'weather_states.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherDataRepository weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherInitial()) {
    on<GetWeatherData>(_onGetWeatherData);

    add(GetWeatherData(Cities.values.first));
  }

  Future<void> _onGetWeatherData(
      GetWeatherData event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    final result = await weatherRepo.fetchWeatherData(
      event.city.toStr,
      tempretureUnit: LocalWeatherData().temperatureScale,
    );

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (data) => data.isEmpty
          ? emit(WeatherError('No data!'))
          : emit(WeatherLoaded(data)),
    );
  }
}
