abstract class WeatherEvent {
  const WeatherEvent();
}

class WeatherRequested extends WeatherEvent {
  final String cityName;

  const WeatherRequested(this.cityName);
}
