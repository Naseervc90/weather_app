import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/weather.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class MainModel {
  final double? temp;
  @JsonKey(name: 'feels_like')
  final double? feelsLike;
  final int? humidity;

  const MainModel({this.temp, this.feelsLike, this.humidity});

  factory MainModel.fromJson(Map<String, dynamic> json) =>
      _$MainModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainModelToJson(this);
}

@JsonSerializable()
class WeatherDetailModel {
  final String? description;
  final String? icon;

  const WeatherDetailModel({this.description, this.icon});

  factory WeatherDetailModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDetailModelToJson(this);
}

@JsonSerializable()
class WindModel {
  final double? speed;

  const WindModel({this.speed});

  factory WindModel.fromJson(Map<String, dynamic> json) =>
      _$WindModelFromJson(json);

  Map<String, dynamic> toJson() => _$WindModelToJson(this);
}

@JsonSerializable()
class WeatherModel {
  @JsonKey(name: 'name')
  final String? cityName;

  @JsonKey(name: 'main')
  final MainModel? main;

  @JsonKey(name: 'weather')
  final List<WeatherDetailModel>? weatherDetails;

  @JsonKey(name: 'wind')
  final WindModel? wind;

  @JsonKey(name: 'dt')
  final int? timestamp;

  WeatherModel({
    this.cityName,
    this.main,
    this.weatherDetails,
    this.wind,
    this.timestamp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  // Convert to domain entity
  Weather toEntity() {
    return Weather(
      cityName: cityName ?? 'Unknown City',
      temperature: (main?.temp ?? 0) - 273.15,
      description:
          weatherDetails?.isNotEmpty == true
              ? weatherDetails!.first.description ?? 'No description'
              : 'No description',
      icon:
          weatherDetails?.isNotEmpty == true
              ? weatherDetails!.first.icon ?? '01d'
              : '01d',
      feelsLike: (main?.feelsLike ?? 0) - 273.15,
      humidity: main?.humidity ?? 0,
      windSpeed: wind?.speed ?? 0,
      dateTime:
          timestamp != null
              ? DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000)
              : DateTime.now(),
    );
  }
}
