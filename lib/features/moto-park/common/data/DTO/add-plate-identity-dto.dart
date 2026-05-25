import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'add-plate-identity-dto.g.dart';

@JsonSerializable()
class AddPlateIdentityDTO extends Equatable {
  final int id;

  AddPlateIdentityDTO({required this.id});

  factory AddPlateIdentityDTO.fromJson(Map<String, dynamic> json) =>
      _$AddPlateIdentityDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AddPlateIdentityDTOToJson(this);

  @override
  List<Object?> get props => [this.id];
}
