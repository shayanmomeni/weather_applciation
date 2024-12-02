import 'package:dartz/dartz.dart';
import 'package:weather_application/core/constants/config.dart';
import 'package:weather_application/core/models/error_response_model.dart';
import 'package:weather_application/core/models/remote_data_model.dart';
import 'package:weather_application/core/utils/enums.dart';
import 'package:weather_application/core/utils/extentions.dart';
import 'package:weather_application/features/weather/data/data/remote_weather_data.dart';
import 'package:weather_application/features/weather/data/model/weather_model.dart';
import 'package:weather_application/features/weather/domain/repo/weather_repo.dart';

class WeatherRepositoryImpl implements WeatherDataRepository {
  final RemoteWeatherDatasource remote;

  WeatherRepositoryImpl({
    required this.remote,
  });

  @override
  Future<Either<RemoteDataFailModel, List<WeatherModel>>> fetchWeatherData(
      String city,
      {required TemperatureScale tempretureUnit}) async {
    try {
      final result = await remote.fetchWeather(
        {
          'q': city,
          'appid': AppConfig().constant.weatherId,
          'units': tempretureUnit.toStr,
        },
      );

      if (result.data['list'] == null) {
        throw ErrorResponseModel(message: 'Failed to fetch Weather data');
      }

      Map<String, WeatherModel> weathersList = {};

      for (var element in result.data['list']) {
        final weather = WeatherModel.fromJson(element);
        weathersList[weather.dtStr] = weather;
      }

      return Right(weathersList.values.toList());
    } on ErrorResponseModel catch (error) {
      print(error.message);
      return Left(
        RemoteDataFailModel(
          message: error.message,
        ),
      );
    } catch (error) {
      if (error is TypeError) {
        print(error.stackTrace.toString());
      }

      return Left(
        RemoteDataFailModel(
          message: error.toString(),
        ),
      );
    }
  }
}
