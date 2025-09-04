/// Core exception classes for the weather app
/// These exceptions are thrown by the data layer and converted to failures
/// in the repository implementation

/// Base exception class for server-related errors
class ServerException implements Exception {
  final String message;

  const ServerException([this.message = 'Server error occurred']);

  @override
  String toString() => 'ServerException: $message';
}

/// Exception thrown when a city is not found in the API
class CityNotFoundException implements Exception {
  final String cityName;
  final String message;

  const CityNotFoundException(this.cityName, [this.message = 'City not found']);

  @override
  String toString() => 'CityNotFoundException: $message for city: $cityName';
}

/// Exception thrown when there are network connectivity issues
class NetworkException implements Exception {
  final String message;

  const NetworkException([this.message = 'Network error occurred']);

  @override
  String toString() => 'NetworkException: $message';
}

/// Exception thrown when API key is invalid or missing
class ApiKeyException implements Exception {
  final String message;

  const ApiKeyException([this.message = 'Invalid or missing API key']);

  @override
  String toString() => 'ApiKeyException: $message';
}

/// Exception thrown when API rate limit is exceeded
class RateLimitException implements Exception {
  final String message;

  const RateLimitException([this.message = 'API rate limit exceeded']);

  @override
  String toString() => 'RateLimitException: $message';
}

/// Exception thrown when API request times out
class TimeoutException implements Exception {
  final String message;

  const TimeoutException([this.message = 'Request timeout']);

  @override
  String toString() => 'TimeoutException: $message';
}

/// Exception thrown when response data format is invalid
class DataFormatException implements Exception {
  final String message;

  const DataFormatException([this.message = 'Invalid data format']);

  @override
  String toString() => 'DataFormatException: $message';
}
