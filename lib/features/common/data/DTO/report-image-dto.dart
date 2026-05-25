import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'report-image-dto.g.dart';

@JsonSerializable()
class ReportImage extends Equatable {
  final int id;
  final int accuracy;
  final String mainImage;
  final String plateImage;
  final int camera;
  final String createdAt;

  ReportImage(
      {required this.accuracy,
      required this.camera,
      required this.createdAt,
      required this.id,
      required this.mainImage,
      required this.plateImage});

  factory ReportImage.fromJson(Map<String, dynamic> json) =>
      _$ReportImageFromJson(json);

  Map<String, dynamic> toJson() => _$ReportImageToJson(this);

  @override
  List<Object?> get props => [
        this.accuracy,
        this.camera,
        this.createdAt,
        this.id,
        this.mainImage,
        this.plateImage
      ];
}
