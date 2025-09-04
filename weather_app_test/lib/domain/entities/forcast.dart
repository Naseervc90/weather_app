import 'package:weather_app_test/domain/entities/weather.dart';

class Forecast {
  final List<Weather> dailyForecasts;

  const Forecast({required this.dailyForecasts});
}
