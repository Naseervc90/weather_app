// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  cityName: json['name'] as String,
  main: MainModel.fromJson(json['main'] as Map<String, dynamic>),
  weather:
      (json['weather'] as List<dynamic>)
          .map((e) => WeatherDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'name': instance.cityName,
      'main': instance.main,
      'weather': instance.weather,
    };

MainModel _$MainModelFromJson(Map<String, dynamic> json) =>
    MainModel(temp: (json['temp'] as num).toDouble());

Map<String, dynamic> _$MainModelToJson(MainModel instance) => <String, dynamic>{
  'temp': instance.temp,
};

WeatherDetailModel _$WeatherDetailModelFromJson(Map<String, dynamic> json) =>
    WeatherDetailModel(
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherDetailModelToJson(WeatherDetailModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'icon': instance.icon,
    };
