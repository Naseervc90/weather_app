import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_test/domain/entities/forcast.dart';
import 'package:weather_app_test/domain/entities/weather.dart';
import 'package:weather_app_test/domain/usecases/get_five_day_forcast.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../../domain/usecases/get_current_weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final GetFiveDayForecast getFiveDayForecast;

  WeatherBloc(this.getCurrentWeather, this.getFiveDayForecast)
    : super(WeatherInitial()) {
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

    final weatherResult = await getCurrentWeather.execute(event.cityName);
    final forecastResult = await getFiveDayForecast.execute(event.cityName);

    if (weatherResult.isRight() && forecastResult.isRight()) {
      emit(
        ForecastLoaded(
          weatherResult.getOrElse(
            () => Weather(
              // fallback to safe default
              cityName: '',
              temperature: 0,
              description: '',
              icon: '',
              feelsLike: 0,
              humidity: 0,
              windSpeed: 0,
              dateTime: DateTime.now(),
            ),
          ),
          forecastResult.getOrElse(() => Forecast(dailyForecasts: [])),
        ),
      );
    } else {
      // Prefer first failure
      final failure =
          weatherResult.fold((l) => l, (r) => null) ??
          forecastResult.fold((l) => l, (r) => null);

      emit(WeatherError(failure?.message ?? 'Unknown error occurred'));
    }
  }
}
