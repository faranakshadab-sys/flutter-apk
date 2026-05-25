// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plate-identity-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlateIdentityDTO _$PlateIdentityDTOFromJson(Map<String, dynamic> json) =>
    PlateIdentityDTO(
      currentPage: json['currentPage'] as int,
      hasNextPage: json['hasNextPage'] as bool,
      hasPreviousPage: json['hasPreviousPage'] as bool,
      isFirstPage: json['isFirstPage'] as bool,
      isLastPage: json['isLastPage'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => PlateIdentity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageSize: json['pageSize'] as int,
      totalFilteredItems: json['totalFilteredItems'] as int,
      totalItems: json['totalItems'] as int,
      totalPages: json['totalPages'] as int,
    );

Map<String, dynamic> _$PlateIdentityDTOToJson(PlateIdentityDTO instance) =>
    <String, dynamic>{
      'pageSize': instance.pageSize,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'currentPage': instance.currentPage,
      'isLastPage': instance.isLastPage,
      'isFirstPage': instance.isFirstPage,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
      'totalFilteredItems': instance.totalFilteredItems,
      'items': instance.items,
    };

PlateIdentity _$PlateIdentityFromJson(Map<String, dynamic> json) =>
    PlateIdentity(
      createdAt: json['createdAt'] as String,
      id: json['id'] as int,
      ownerFirstName: json['ownerFirstName'] as String,
      ownerLastName: json['ownerLastName'] as String,
      ownerMobileNumber: json['ownerMobileNumber'] as String,
      plateNumberPart1: json['plateNumberPart1'] as int,
      plateNumberPart2: json['plateNumberPart2'] as String,
      plateNumberPart3: json['plateNumberPart3'] as int,
      plateNumberPart4: json['plateNumberPart4'] as int,
    );

Map<String, dynamic> _$PlateIdentityToJson(PlateIdentity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plateNumberPart1': instance.plateNumberPart1,
      'plateNumberPart2': instance.plateNumberPart2,
      'plateNumberPart3': instance.plateNumberPart3,
      'plateNumberPart4': instance.plateNumberPart4,
      'ownerMobileNumber': instance.ownerMobileNumber,
      'ownerFirstName': instance.ownerFirstName,
      'ownerLastName': instance.ownerLastName,
      'createdAt': instance.createdAt,
    };
