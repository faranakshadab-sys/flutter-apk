import 'package:equatable/equatable.dart';

class PlateIdentityModel extends Equatable {
  final int id;
  final int plateNumberPart1;
  final String plateNumberPart2;
  final int plateNumberPart3;
  final int plateNumberPart4;
  final String ownerMobileNumber;
  final String ownerFirstName;
  final String ownerLastName;

  PlateIdentityModel(
      {required this.id,
      required this.ownerFirstName,
      required this.ownerLastName,
      required this.ownerMobileNumber,
      required this.plateNumberPart1,
      required this.plateNumberPart2,
      required this.plateNumberPart3,
      required this.plateNumberPart4});

  @override
  List<Object?> get props => [
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
