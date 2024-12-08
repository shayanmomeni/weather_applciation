import 'package:flutter_test/flutter_test.dart';
import 'package:weather_application/core/constants/config.dart';
import 'package:weather_application/core/utils/enums.dart';
import 'package:weather_application/core/utils/extentions.dart';

void main() {
  group('TemperatureScaleExtension', () {
    test('unitSymbol returns correct symbol', () {
      expect(TemperatureScale.metric.unitSymbol, '°C');
      expect(TemperatureScale.imperial.unitSymbol, '°F');
    });

    test('toStr returns correct string', () {
      expect(TemperatureScale.metric.toStr, 'metric');
      expect(TemperatureScale.imperial.toStr, 'imperial');
    });
  });

  group('TemperatureScaleStrExtension', () {
    test('toTemperatureScale returns correct TemperatureScale', () {
      expect('metric'.toTemperatureScale, TemperatureScale.metric);
      expect('imperial'.toTemperatureScale, TemperatureScale.imperial);
    });
  });

  group('CitiesExtension', () {
    test('toStr returns correct city name', () {
      expect(Cities.heilbronn.toStr, 'Heilbronn');
      expect(Cities.berlin.toStr, 'Berlin');
      expect(Cities.paris.toStr, 'Paris');
      expect(Cities.london.toStr, 'London');
      expect(Cities.newyork.toStr, 'New York');
    });
  });

  group('DateTimeExtension', () {
    test('nameStr returns correct day name', () {
      DateTime date = DateTime(2023, 10, 1);
      expect(date.nameStr, 'Sunday');
    });

    test('nameAbbrStr returns correct abbreviated day name', () {
      DateTime date = DateTime(2023, 10, 1);
      expect(date.nameAbbrStr, 'Sun');
    });
  });

  group('DateTimeIntExtension', () {
    test('convertToDateTime returns correct DateTime', () {
      int timestamp = 1633072800; // 1st October 2021, 00:00:00 UTC
      DateTime expectedDate =
          DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
      expect(timestamp.convertToDateTime, expectedDate);
    });
  });

  group('WeatherIconUrlExtension', () {
    test('toWeatherIconUrl returns correct URL', () {
      String iconCode = '10d';
      String expectedUrl = '${AppConfig().constant.iconUrl}/10d@4x.png';
      expect(iconCode.toWeatherIconUrl, expectedUrl);
    });
  });
}
