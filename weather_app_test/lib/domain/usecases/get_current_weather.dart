import 'package:dartz/dartz.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';
import '../../core/error/failure.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, Weather>> execute(String cityName) async {
    return await repository.getCurrentWeather(cityName);
  }
}
