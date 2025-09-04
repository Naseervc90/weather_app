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

  const WeatherModel({
    required this.cityName,
    required this.main,
    required this.weather,
  }) : super(cityName: cityName, temperature: 0, description: '', icon: '');

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  @override
  double get temperature => main.temp - 273.15; // Convert from Kelvin to Celsius

  @override
  String get description => weather.first.description;

  @override
  String get icon => weather.first.icon;
}

@JsonSerializable()
class MainModel {
  final double temp;

  const MainModel({required this.temp});

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
