import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app_test/domain/entities/forcast.dart';

import 'weather_model.dart';
part 'forcast_model.g.dart';

@JsonSerializable()
class ForecastModel extends Forecast {
  @JsonKey(name: 'list')
  final List<WeatherModel> forecasts;

  const ForecastModel({required this.forecasts})
    : super(dailyForecasts: forecasts);

  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastModelToJson(this);
}
