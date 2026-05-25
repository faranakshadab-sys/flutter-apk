import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plate-identity-dto.g.dart';

@JsonSerializable()
class PlateIdentityDTO extends Equatable {
  final int pageSize;
  final int totalPages;
  final int totalItems;
  final int currentPage;
  final bool isLastPage;
  final bool isFirstPage;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int totalFilteredItems;
  final List<PlateIdentity> items;

  PlateIdentityDTO(
      {required this.currentPage,
      required this.hasNextPage,
      required this.hasPreviousPage,
      required this.isFirstPage,
      required this.isLastPage,
      required this.items,
      required this.pageSize,
      required this.totalFilteredItems,
      required this.totalItems,
      required this.totalPages});

  factory PlateIdentityDTO.fromJson(Map<String, dynamic> json) =>
      _$PlateIdentityDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PlateIdentityDTOToJson(this);

  @override
  List<Object?> get props => [
        this.currentPage,
        this.hasNextPage,
        this.hasPreviousPage,
        this.isFirstPage,
        this.isLastPage,
        this.items,
        this.pageSize,
        this.totalFilteredItems,
        this.totalItems,
        this.totalPages
      ];
}

@JsonSerializable()
class PlateIdentity extends Equatable {
  final int id;
  final int plateNumberPart1;
  final String plateNumberPart2;
  final int plateNumberPart3;
  final int plateNumberPart4;
  final String ownerMobileNumber;
  final String ownerFirstName;
  final String ownerLastName;
  final String createdAt;

  PlateIdentity(
      {required this.createdAt,
      required this.id,
      required this.ownerFirstName,
      required this.ownerLastName,
      required this.ownerMobileNumber,
      required this.plateNumberPart1,
      required this.plateNumberPart2,
      required this.plateNumberPart3,
      required this.plateNumberPart4});

  factory PlateIdentity.fromJson(Map<String, dynamic> json) =>
      _$PlateIdentityFromJson(json);

  Map<String, dynamic> toJson() => _$PlateIdentityToJson(this);

  @override
  List<Object?> get props => [
        this.createdAt,
        this.id,
        this.ownerFirstName,
        this.ownerLastName,
        this.ownerMobileNumber,
        this.plateNumberPart1,
        this.plateNumberPart2,
        this.plateNumberPart3,
        this.plateNumberPart4
      ];
}
