import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/weather.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel extends Weather {
  @JsonKey(name: 'name')
  final String cityName;

  @JsonKey(name: 'main')
  final MainModel main;

  @JsonKey(name: 'weather')
  final List<WeatherDetailModel> weather;

  @JsonKey(name: 'wind')
  final WindModel wind;

  @JsonKey(name: 'dt')
  final int timestamp;

  WeatherModel({
    required this.cityName,
    required this.main,
    required this.weather,
    required this.wind,
    required this.timestamp,
  }) : super(
         cityName: cityName,
         temperature: 0,
         description: '',
         icon: '',
         feelsLike: 0,
         humidity: 0,
         windSpeed: 0,
         dateTime: DateTime.now(),
       );

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  @override
  double get temperature => main.temp - 273.15;

  @override
  String get description => weather.first.description;

  @override
  String get icon => weather.first.icon;

  @override
  double get feelsLike => main.feelsLike - 273.15;

  @override
  int get humidity => main.humidity;

  @override
  double get windSpeed => wind.speed;

  @override
  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}

@JsonSerializable()
class MainModel {
  final double temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  final int humidity;

  const MainModel({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) =>
      _$MainModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainModelToJson(this);
}

@JsonSerializable()
class WeatherDetailModel {
  final String description;
  final String icon;

  const WeatherDetailModel({required this.description, required this.icon});

  factory WeatherDetailModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDetailModelToJson(this);
}

@JsonSerializable()
class WindModel {
  final double speed;

  const WindModel({required this.speed});

  factory WindModel.fromJson(Map<String, dynamic> json) =>
      _$WindModelFromJson(json);

  Map<String, dynamic> toJson() => _$WindModelToJson(this);
}
