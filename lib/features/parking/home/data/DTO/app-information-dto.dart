import 'package:equatable/equatable.dart';

class AppInformationDTO extends Equatable {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  AppInformationDTO(
      {required this.appName,
      required this.buildNumber,
      required this.packageName,
      required this.version});

  @override
  List<Object?> get props =>
      [this.appName, this.buildNumber, this.packageName, this.version];
}
