import 'package:dartz/dartz.dart';
import 'package:weather_application/core/models/remote_data_model.dart';
import 'package:weather_application/core/utils/enums.dart';
import 'package:weather_application/features/weather/data/model/weather_model.dart';

abstract class WeatherDataRepository {
  Future<Either<RemoteDataFailModel, List<WeatherModel>>> fetchWeatherData(
    String city, {
    required TemperatureScale tempretureUnit,
  });
}
