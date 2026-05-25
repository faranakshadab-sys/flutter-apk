import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String fullName;
  final String roleName;
  final String accessToken;
  final String refreshToken;
  final String uniqueIdentifier;

  LoginModel(
      {required this.fullName,
      required this.roleName,
      required this.accessToken,
      required this.refreshToken,
      required this.uniqueIdentifier});

  @override
  List<Object?> get props => [
        this.fullName,
        this.roleName,
        this.uniqueIdentifier,
        this.accessToken,
        this.refreshToken,
      ];
}
