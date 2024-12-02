import 'package:dio/dio.dart';
import 'package:weather_application/core/data/remote/data_source.dart';
import 'package:weather_application/core/models/error_response_model.dart';

class RemoteWeatherDatasource extends RemoteDatasource {
  Future<Response> fetchWeather(
    Map<String, dynamic> queryParameters,
  ) async {
    try {
      return await get(
        'forecast',
        queryParameters: queryParameters,
      );
    } catch (e) {
      print(e);
      throw ErrorResponseModel(
          message: 'Failed to fetch Weather data from the server');
    }
  }
}
