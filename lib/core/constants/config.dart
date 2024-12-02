import 'package:weather_application/core/constants/app_constants.dart';
import 'package:weather_application/core/constants/colors.dart';
import 'package:weather_application/core/constants/dimens.dart';

class AppConfig {
  static final AppConfig _singleton = AppConfig._internal();
  factory AppConfig() => _singleton;
  AppConfig._internal();

  final colors = AppColors();
  final dimens = Dimens();
  final constant = AppConstants();
 
  
}
