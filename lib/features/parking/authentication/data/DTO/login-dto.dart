import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login-dto.g.dart';

@JsonSerializable()
class LoginDTO extends Equatable {
  final String accessToken;
  final String refreshToken;
  final int accessTokenExpireTime;
  final int refreshTokenExpireTime;
  final int userId;
  final String fullName;
  final String roleName;
  final String uniqueIdentifier;

  LoginDTO(
      {required this.accessToken,
      required this.accessTokenExpireTime,
      required this.fullName,
      required this.refreshToken,
      required this.refreshTokenExpireTime,
      required this.roleName,
      required this.uniqueIdentifier,
      required this.userId});

  factory LoginDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);

  @override
  List<Object?> get props => [
        this.accessToken,
        this.accessTokenExpireTime,
        this.fullName,
        this.refreshToken,
        this.refreshTokenExpireTime,
        this.roleName,
        this.uniqueIdentifier,
        this.userId
      ];
}
