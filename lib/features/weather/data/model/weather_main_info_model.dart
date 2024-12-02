class WeatherMainInfoModel {
  final int id;
  final String main;
  final String description;
  final String icon;

  const WeatherMainInfoModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherMainInfoModel.fromJson(Map<String, dynamic> json) {
    return WeatherMainInfoModel(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
