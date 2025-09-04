import 'package:dartz/dartz.dart';
import 'package:weather_app_test/domain/entities/forcast.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../core/error/failure.dart';
import '../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../datasources/weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final hasConnection = await networkInfo.isConnected;
      if (!hasConnection) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final weatherModel = await remoteDataSource.getCurrentWeather(cityName);
      final weather = weatherModel.toEntity(); // Convert to domain entity
      return Right(weather);
    } on CityNotFoundException {
      return const Left(CityNotFoundFailure('City not found'));
    } on ApiKeyException {
      return const Left(ServerFailure('Invalid API key'));
    } on ServerException {
      return const Left(ServerFailure('Server error occurred'));
    } catch (e) {
      return Left(NetworkFailure('No Network'));
    }
  }

  @override
  Future<Either<Failure, Forecast>> getFiveDayForecast(String cityName) async {
    try {
      final hasConnection = await networkInfo.isConnected;
      if (!hasConnection) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final forecastModel = await remoteDataSource.getFiveDayForecast(cityName);
      final forecast = forecastModel.toEntity(); // Convert to domain entity
      return Right(forecast);
    } on CityNotFoundException {
      return const Left(CityNotFoundFailure('City not found'));
    } on ApiKeyException {
      return const Left(ServerFailure('Invalid API key'));
    } on ServerException {
      return const Left(ServerFailure('Server error occurred'));
    } catch (e) {
      return Left(NetworkFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
