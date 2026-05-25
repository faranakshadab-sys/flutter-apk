import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment-status-dto.g.dart';

@JsonSerializable()
class PaymentStatusDTO extends Equatable {
  final bool status;

  PaymentStatusDTO({required this.status});

  factory PaymentStatusDTO.fromJson(Map<String, dynamic> json) =>
      _$PaymentStatusDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentStatusDTOToJson(this);

  @override
  List<Object?> get props => [this.status];
}
