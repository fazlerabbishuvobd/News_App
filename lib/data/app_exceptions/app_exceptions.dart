class AppException implements Exception {
  final String message;
  AppException({required this.message});

  @override
  String toString() {
    return message;
  }
}

class InternetException extends AppException {
  InternetException({String? message}) : super(message: message ?? 'NO INTERNET');
}

class RequestTimeoutException extends AppException {
  RequestTimeoutException({String? message}) : super(message: message ?? 'REQUEST TIME OUT');
}

class InternalServerException extends AppException {
  InternalServerException({String? message}) : super(message: message ?? 'SERVER ERROR');
}

class BadRequestException extends AppException {
  BadRequestException({String? message}) : super(message: message ?? 'BAD REQUEST');
}

class UnauthorizedException extends AppException {
  UnauthorizedException({String? message}) : super(message: message ?? 'UNAUTHORIZED');
}

class TooManyRequestsException extends AppException {
  TooManyRequestsException({String? message}) : super(message: message ?? 'TOO MANY REQUESTS');
}

class ServerErrorException extends AppException {
  ServerErrorException({String? message}) : super(message: message ?? 'SERVER ERROR');
}

class UnknownException extends AppException {
  UnknownException(String string, {String? message}) : super(message: message ?? 'UNKNOWN ERROR');
}
