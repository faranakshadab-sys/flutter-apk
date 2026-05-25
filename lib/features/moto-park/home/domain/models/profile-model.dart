import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String roleName;
  final String firstName;
  final String lastName;
  final String username;
  final String lastLoginAt;

  ProfileModel(
      {required this.firstName,
      required this.lastLoginAt,
      required this.lastName,
      required this.roleName,
      required this.username});

  @override
  List<Object?> get props => [
        this.firstName,
        this.lastLoginAt,
        this.lastName,
        this.roleName,
        this.username
      ];
}
