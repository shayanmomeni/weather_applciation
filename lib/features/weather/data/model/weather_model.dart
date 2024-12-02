import 'package:weather_application/features/weather/data/model/clouds_model.dart';
import 'package:weather_application/features/weather/data/model/weather_details_model.dart';
import 'package:weather_application/features/weather/data/model/weather_main_info_model.dart';
import 'package:weather_application/features/weather/data/model/wind_model.dart';

class WeatherModel {
  final List<WeatherMainInfoModel> weather;
  final WeatherDetailsModel main;
  final int visibility;
  final WindModel wind;
  final CloudsModel clouds;
  final int dt;
  final String dtStr;
  final DateTime dtAsDateTime;

  const WeatherModel({
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.dtStr,
    required this.dtAsDateTime,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['dt_txt']);
    return WeatherModel(
      weather: (json['weather'] as List<dynamic>)
          .map<WeatherMainInfoModel>((w) => WeatherMainInfoModel.fromJson(w))
          .toList(),
      main: WeatherDetailsModel.fromJson(json['main']),
      visibility: json['visibility'] ?? 0,
      wind: WindModel.fromJson(json['wind']),
      clouds: CloudsModel.fromJson(json['clouds']),
      dtStr: '${date.year}-${date.month}-${date.day}',
      dt: json['dt'],
      dtAsDateTime: date,
    );
  }

  factory WeatherModel.empty() {
    return WeatherModel(
      weather: [],
      main: WeatherDetailsModel.empty(),
      visibility: 0,
      wind: WindModel.empty(),
      clouds: CloudsModel.empty(),
      dt: 0,
      dtStr: '',
      dtAsDateTime: DateTime.now(),
    );
  }
}
