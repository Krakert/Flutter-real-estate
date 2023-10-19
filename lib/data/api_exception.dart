// Exceptions for the API call
sealed class APIException implements Exception {
  APIException(this.message);
  final String message;
}

class InvalidApiKeyException extends APIException {
  InvalidApiKeyException() : super('Invalid API key');
}

class NoInternetConnectionException extends APIException {
  NoInternetConnectionException() : super('No Internet connection');
}

class NotFoundException extends APIException {
  NotFoundException() : super('City not found');
}

class UnknownException extends APIException {
  UnknownException() : super('Some error occurred');
}