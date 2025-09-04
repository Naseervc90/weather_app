import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/forcast.dart';
import '../../domain/entities/weather.dart';
import '../../domain/usecases/get_five_day_forcast.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../../domain/usecases/get_current_weather.dart';
import '../../core/error/failure.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final GetFiveDayForecast getFiveDayForecast;

  WeatherBloc({
    required this.getCurrentWeather,
    required this.getFiveDayForecast,
  }) : super(WeatherInitial()) {
    on<WeatherRequested>(_onWeatherRequested);
    on<ForecastRequested>(_onForecastRequested);
  }

  Future<void> _onWeatherRequested(
    WeatherRequested event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    final result = await getCurrentWeather.execute(event.cityName);

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  Future<void> _onForecastRequested(
    ForecastRequested event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    final Either<Failure, Weather> weatherResult = await getCurrentWeather
        .execute(event.cityName);
    final Either<Failure, Forecast> forecastResult = await getFiveDayForecast
        .execute(event.cityName);

    if (weatherResult.isRight() && forecastResult.isRight()) {
      final weather = weatherResult.getOrElse(
        () => throw Exception("No weather data"),
      );
      final forecast = forecastResult.getOrElse(
        () => throw Exception("No forecast data"),
      );
      emit(ForecastLoaded(weather, forecast));
    } else {
      final failure =
          weatherResult.fold((l) => l, (r) => null) ??
          forecastResult.fold((l) => l, (r) => null);
      emit(WeatherError(failure?.message ?? 'Unknown error occurred'));
    }
  }
}
