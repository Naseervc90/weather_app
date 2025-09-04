import 'package:dartz/dartz.dart';
import 'package:weather_app_test/domain/entities/forcast.dart';
import '../entities/weather.dart';

import '../../core/error/failure.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
  Future<Either<Failure, Forecast>> getFiveDayForecast(String cityName);
}
