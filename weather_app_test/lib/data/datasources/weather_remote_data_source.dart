import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../../core/error/exceptions.dart';
import '../../data/models/weather_model.dart';
import '../../data/models/forecast_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
  Future<ForecastModel> getFiveDayForecast(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}/weather?q=$cityName&appid=${ApiConstants.apiKey}',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return WeatherModel.fromJson(json);
    } else if (response.statusCode == 404) {
      throw CityNotFoundException(cityName);
    } else if (response.statusCode == 401) {
      throw ApiKeyException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ForecastModel> getFiveDayForecast(String cityName) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}/forecast?q=$cityName&appid=${ApiConstants.apiKey}',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ForecastModel.fromJson(json);
    } else if (response.statusCode == 404) {
      throw CityNotFoundException(cityName);
    } else if (response.statusCode == 401) {
      throw ApiKeyException();
    } else {
      throw ServerException();
    }
  }
}
