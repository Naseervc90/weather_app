import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app_test/domain/entities/forcast.dart';

import '../../domain/entities/weather.dart';
import 'weather_model.dart';

part 'forcast_model.g.dart';

@JsonSerializable()
class ForecastModel {
  @JsonKey(name: 'list')
  final List<WeatherModel>? dailyForecasts;

  ForecastModel({this.dailyForecasts});

  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastModelToJson(this);

  // Convert to domain entity
  Forecast toEntity() {
    return Forecast(
      dailyForecasts:
          dailyForecasts
              ?.map(
                (weatherModel) => Weather(
                  cityName: weatherModel.cityName ?? 'Unknown City',
                  temperature: (weatherModel.main?.temp ?? 0) - 273.15,
                  description:
                      weatherModel.weatherDetails?.isNotEmpty == true
                          ? weatherModel.weatherDetails!.first.description ??
                              'No description'
                          : 'No description',
                  icon:
                      weatherModel.weatherDetails?.isNotEmpty == true
                          ? weatherModel.weatherDetails!.first.icon ?? '01d'
                          : '01d',
                  feelsLike: (weatherModel.main?.feelsLike ?? 0) - 273.15,
                  humidity: weatherModel.main?.humidity ?? 0,
                  windSpeed: weatherModel.wind?.speed ?? 0,
                  dateTime:
                      weatherModel.timestamp != null
                          ? DateTime.fromMillisecondsSinceEpoch(
                            weatherModel.timestamp! * 1000,
                          )
                          : DateTime.now(),
                ),
              )
              .toList() ??
          [],
    );
  }
}
