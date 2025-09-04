// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forcast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastModel _$ForecastModelFromJson(Map<String, dynamic> json) =>
    ForecastModel(
      dailyForecasts:
          (json['list'] as List<dynamic>?)
              ?.map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ForecastModelToJson(ForecastModel instance) =>
    <String, dynamic>{'list': instance.dailyForecasts};
