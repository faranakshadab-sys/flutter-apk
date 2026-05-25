import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile-dto.g.dart';

@JsonSerializable()
class ProfileDTO extends Equatable {
  final int id;
  final String roleName;
  final String firstName;
  final String lastName;
  final String username;
  final String createdAt;
  final String lastLoginAt;

  ProfileDTO(
      {required this.createdAt,
      required this.firstName,
      required this.id,
      required this.lastLoginAt,
      required this.lastName,
      required this.roleName,
      required this.username});

  factory ProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$ProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDTOToJson(this);

  @override
  List<Object?> get props => [
        this.createdAt,
        this.firstName,
        this.id,
        this.lastLoginAt,
        this.lastName,
        this.roleName,
        this.username
      ];
}
