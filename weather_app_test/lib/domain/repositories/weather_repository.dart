import 'package:dartz/dartz.dart';
import '../entities/weather.dart';
import '../../core/error/failure.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
