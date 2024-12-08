class WeatherDetailsModel {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevelPressure;
  final int groundLevelPressure;

  const WeatherDetailsModel({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevelPressure,
    required this.groundLevelPressure,
  });

  factory WeatherDetailsModel.fromJson(Map<String, dynamic> json) {
    return WeatherDetailsModel(
      temp: (json['temp'] ?? 0).toDouble(),
      feelsLike: (json['feels_like'] ?? 0).toDouble(),
      tempMin: (json['temp_min'] ?? 0).toDouble(),
      tempMax: (json['temp_max'] ?? 0).toDouble(),
      pressure: json['pressure'] ?? 0,
      humidity: json['humidity'] ?? 0,
      seaLevelPressure: json['sea_level'] ?? 0,
      groundLevelPressure: json['grnd_level'] ?? 0,
    );
  }

  factory WeatherDetailsModel.empty() {
    return const WeatherDetailsModel(
      temp: 0,
      feelsLike: 0,
      tempMin: 0,
      tempMax: 0,
      pressure: 0,
      humidity: 0,
      seaLevelPressure: 0,
      groundLevelPressure: 0,
    );
  }
}
