import 'package:dartz/dartz.dart';
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
    if (await networkInfo.isConnected) {
      try {
        final weather = await remoteDataSource.getCurrentWeather(cityName);
        return Right(weather);
      } on CityNotFoundException {
        return const Left(CityNotFoundFailure('City not found'));
      } on ServerException {
        return const Left(ServerFailure('Server error occurred'));
      } catch (e) {
        return Left(NetworkFailure('Network error: ${e.toString()}'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
