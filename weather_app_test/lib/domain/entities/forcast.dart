import 'package:equatable/equatable.dart';
import 'weather.dart';

class Forecast extends Equatable {
  final List<Weather> dailyForecasts;

  const Forecast({required this.dailyForecasts});

  @override
  List<Object> get props => [dailyForecasts];
}
