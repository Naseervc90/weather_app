import 'package:weather_app_test/domain/entities/forcast.dart';

import '../../domain/entities/weather.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded(this.weather);
}

class ForecastLoaded extends WeatherState {
  final Weather currentWeather;
  final Forecast forecast;

  const ForecastLoaded(this.currentWeather, this.forecast);
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);
}
