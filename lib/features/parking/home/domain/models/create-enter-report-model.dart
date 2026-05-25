import 'package:equatable/equatable.dart';

class CreateEnterReportModel extends Equatable {
  final String id;
  final String entryDate;
  final String parkingName;
  final String parkingAddress;
  final String parkingPhone;

  CreateEnterReportModel(
      {required this.id,
      required this.entryDate,
      required this.parkingAddress,
      required this.parkingName,
      required this.parkingPhone});

  @override
  List<Object?> get props => [
        this.id,
        this.entryDate,
        this.parkingAddress,
        this.parkingName,
        this.parkingPhone
      ];
}
