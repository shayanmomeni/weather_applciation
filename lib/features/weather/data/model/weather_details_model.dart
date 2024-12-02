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
      temp: json['temp'] is int ? json['temp'].toDouble() : json['temp'],
      feelsLike: json['feels_like'] is int
          ? json['feels_like'].toDouble()
          : json['feels_like'],
      tempMin: json['temp_min'] is int
          ? json['temp_min'].toDouble()
          : json['temp_min'],
      tempMax: json['temp_max'] is int
          ? json['temp_max'].toDouble()
          : json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      seaLevelPressure: json['sea_level'], 
      groundLevelPressure: json['grnd_level'], 
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