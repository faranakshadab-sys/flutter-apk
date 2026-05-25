import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detected-plate-dto.g.dart';

@JsonSerializable()
class DetectedPlateDTO extends Equatable {
  final String plateNumber;
  final String base64Image;

  DetectedPlateDTO({required this.base64Image, required this.plateNumber});

  factory DetectedPlateDTO.fromJson(Map<String, dynamic> json) =>
      _$DetectedPlateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DetectedPlateDTOToJson(this);

  @override
  List<Object?> get props => [this.base64Image, this.plateNumber];
}
