import 'package:equatable/equatable.dart';

class DetectedPlateModel extends Equatable {
  final String plateNumber;
  final String base64Image;

  DetectedPlateModel({required this.base64Image, required this.plateNumber});

  @override
  List<Object?> get props => [this.base64Image, this.plateNumber];
}
