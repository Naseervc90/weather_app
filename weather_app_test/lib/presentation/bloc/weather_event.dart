import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherRequested extends WeatherEvent {
  final String cityName;

  const WeatherRequested(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class ForecastRequested extends WeatherEvent {
  final String cityName;

  const ForecastRequested(this.cityName);

  @override
  List<Object> get props => [cityName];
}
