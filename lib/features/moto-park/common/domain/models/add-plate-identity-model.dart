import 'package:equatable/equatable.dart';

class AddPlateIdentityModel extends Equatable {
  final int id;

  AddPlateIdentityModel({required this.id});

  @override
  List<Object?> get props => [this.id];
}
