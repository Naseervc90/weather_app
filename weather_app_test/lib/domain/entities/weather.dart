import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final DateTime dateTime;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.dateTime,
  });

  @override
  List<Object> get props => [
    cityName,
    temperature,
    description,
    icon,
    feelsLike,
    humidity,
    windSpeed,
    dateTime,
  ];
}
