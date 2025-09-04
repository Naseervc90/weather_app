abstract class WeatherEvent {
  const WeatherEvent();
}

class WeatherRequested extends WeatherEvent {
  final String cityName;

  const WeatherRequested(this.cityName);
}

class ForecastRequested extends WeatherEvent {
  final String cityName;

  const ForecastRequested(this.cityName);
}

class ThemeToggled extends WeatherEvent {}
