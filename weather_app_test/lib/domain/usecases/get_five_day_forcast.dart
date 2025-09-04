import 'package:dartz/dartz.dart';
import 'package:weather_app_test/domain/entities/forcast.dart';
import '../repositories/weather_repository.dart';
import '../../core/error/failure.dart';

class GetFiveDayForecast {
  final WeatherRepository repository;

  GetFiveDayForecast(this.repository);

  Future<Either<Failure, Forecast>> execute(String cityName) async {
    return await repository.getFiveDayForecast(cityName);
  }
}
