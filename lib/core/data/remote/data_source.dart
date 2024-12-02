import 'package:dio/dio.dart';
import 'package:weather_application/core/constants/config.dart';

class RemoteDatasource {
  final Dio _remoteService = Dio();

  Future<Response> get(String function,
      {Map<String, dynamic>? queryParameters}) async {
    return await _remoteService.get(
      "${AppConfig().constant.baseUrl}/$function",
      queryParameters: queryParameters,
    );
  }
}
