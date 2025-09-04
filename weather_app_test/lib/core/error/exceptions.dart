class ServerException implements Exception {}

class CityNotFoundException implements Exception {
  final String cityName;

  CityNotFoundException(this.cityName);
}

class ApiKeyException implements Exception {}
