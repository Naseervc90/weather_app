import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/weather.dart';

part 'weather_model.g.dart';

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

@JsonSerializable()
class WeatherModel extends Weather {
  @JsonKey(name: 'name')
  final String cityName;

  @JsonKey(name: 'main')
  final MainModel main;

  @JsonKey(name: 'weather')
  final List<WeatherDetailModel> weatherDetails;

  @JsonKey(name: 'wind')
  final WindModel wind;

  @JsonKey(name: 'dt')
  final int timestamp;

  WeatherModel({
    required this.cityName,
    required this.main,
    required this.weatherDetails,
    required this.wind,
    required this.timestamp,
  }) : super(
         cityName: cityName,
         temperature: main.temp - 273.15,
         description:
             weatherDetails.isNotEmpty ? weatherDetails.first.description : '',
         icon: weatherDetails.isNotEmpty ? weatherDetails.first.icon : '',
         feelsLike: main.feelsLike - 273.15,
         humidity: main.humidity,
         windSpeed: wind.speed,
         dateTime: DateTime.fromMillisecondsSinceEpoch(timestamp * 1000),
       );

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}
