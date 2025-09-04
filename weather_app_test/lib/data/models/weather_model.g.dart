// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainModel _$MainModelFromJson(Map<String, dynamic> json) => MainModel(
  temp: (json['temp'] as num?)?.toDouble(),
  feelsLike: (json['feels_like'] as num?)?.toDouble(),
  humidity: (json['humidity'] as num?)?.toInt(),
);

Map<String, dynamic> _$MainModelToJson(MainModel instance) => <String, dynamic>{
  'temp': instance.temp,
  'feels_like': instance.feelsLike,
  'humidity': instance.humidity,
};

WeatherDetailModel _$WeatherDetailModelFromJson(Map<String, dynamic> json) =>
    WeatherDetailModel(
      description: json['description'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$WeatherDetailModelToJson(WeatherDetailModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'icon': instance.icon,
    };

WindModel _$WindModelFromJson(Map<String, dynamic> json) =>
    WindModel(speed: (json['speed'] as num?)?.toDouble());

Map<String, dynamic> _$WindModelToJson(WindModel instance) => <String, dynamic>{
  'speed': instance.speed,
};

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  cityName: json['name'] as String?,
  main:
      json['main'] == null
          ? null
          : MainModel.fromJson(json['main'] as Map<String, dynamic>),
  weatherDetails:
      (json['weather'] as List<dynamic>?)
          ?.map((e) => WeatherDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  wind:
      json['wind'] == null
          ? null
          : WindModel.fromJson(json['wind'] as Map<String, dynamic>),
  timestamp: (json['dt'] as num?)?.toInt(),
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'name': instance.cityName,
      'main': instance.main,
      'weather': instance.weatherDetails,
      'wind': instance.wind,
      'dt': instance.timestamp,
    };
