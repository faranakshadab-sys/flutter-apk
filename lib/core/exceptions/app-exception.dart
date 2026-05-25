abstract class AppExceptions implements Exception {
  final String message;
  final int? statusCode;

  AppExceptions({required this.message, this.statusCode});
}

class ServerException extends AppExceptions {
  ServerException({required super.message, super.statusCode});
}

class LocalException extends AppExceptions {
  LocalException({required super.message, super.statusCode});
}

class DissconnectException extends AppExceptions {
  DissconnectException({required super.message, super.statusCode});
}

class DioException extends AppExceptions {
  DioException({required super.message, super.statusCode});
}
