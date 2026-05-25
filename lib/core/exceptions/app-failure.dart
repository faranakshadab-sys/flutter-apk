abstract class AppFailure {
  final String message;
  final int? statusCode;

  AppFailure({required this.message, this.statusCode});
}

class ServerFailure extends AppFailure {
  ServerFailure({required super.message, super.statusCode});
}

class LocalFailure extends AppFailure {
  LocalFailure({required super.message, super.statusCode});
}

class DissconnectFailure extends AppFailure {
  DissconnectFailure({required super.message, super.statusCode});
}

class DioFailure extends AppFailure {
  DioFailure({required super.message, super.statusCode});
}
