import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create-enter-report-dto.g.dart';

@JsonSerializable()
class CreateEnterReportDTO extends Equatable {
  final String id;
  final String entryDate;
  final String parkingName;
  final String parkingAddress;
  final String parkingPhone;

  CreateEnterReportDTO(
      {required this.id,
      required this.entryDate,
      required this.parkingAddress,
      required this.parkingName,
      required this.parkingPhone});

  factory CreateEnterReportDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateEnterReportDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CreateEnterReportDTOToJson(this);

  @override
  List<Object?> get props => [
        this.entryDate,
        this.parkingAddress,
        this.parkingName,
        this.parkingPhone
      ];
}
