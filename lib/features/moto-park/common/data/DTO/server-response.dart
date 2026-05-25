import 'package:parkingandroid/features/moto-park/authentication/data/DTO/login-dto.dart';
import 'package:parkingandroid/features/moto-park/common/data/DTO/add-plate-identity-dto.dart';
import 'package:parkingandroid/features/moto-park/common/data/DTO/payment-status-dto.dart';
import 'package:parkingandroid/features/moto-park/common/data/DTO/plate-identity-dto.dart';
import 'package:parkingandroid/features/moto-park/common/data/DTO/reports-dto.dart';
import 'package:parkingandroid/features/moto-park/home/data/DTO/profile-dto.dart';
import 'package:parkingandroid/features/moto-park/home/data/DTO/report-dto.dart';
import 'package:parkingandroid/features/moto-park/reports/data/DTO/report-information-dto.dart';

class ServerResponse<T> {
  final bool isSucceeded;
  final int apiStatus;
  final List<dynamic> apiErrors;
  final T? apiData;

  ServerResponse(
      {required this.apiData,
      required this.apiErrors,
      required this.apiStatus,
      required this.isSucceeded});

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    switch (T) {
      case LoginDTO:
        {
          return ServerResponse(
              apiData: json["apiData"] != null
                  ? LoginDTO.fromJson(json["apiData"]) as T
                  : null,
              apiErrors: json["apiErrors"],
              apiStatus: json["apiStatus"],
              isSucceeded: json["isSucceeded"]);
        }

      case ReportsDTO:
        {
          return ServerResponse(
              apiData: json["apiData"] != null
                  ? ReportsDTO.fromJson(json["apiData"]) as T
                  : null,
              apiErrors: json["apiErrors"],
              apiStatus: json["apiStatus"],
              isSucceeded: json["isSucceeded"]);
        }

      case ReportDTO:
        {
          return ServerResponse(
              apiData: json["apiData"] != null
                  ? ReportDTO.fromJson(json["apiData"]) as T
                  : null,
              apiErrors: json["apiErrors"],
              apiStatus: json["apiStatus"],
              isSucceeded: json["isSucceeded"]);
        }
      case ReportInformationDTO:
        {
          return ServerResponse(
              apiData: json["apiData"] != null
                  ? ReportInformationDTO.fromJson(json["apiData"]) as T
                  : null,
              apiErrors: json["apiErrors"],
              apiStatus: json["apiStatus"],
              isSucceeded: json["isSucceeded"]);
        }

      case ProfileDTO:
        {
          return ServerResponse(
              apiData: json["apiData"] != null
                  ? ProfileDTO.fromJson(json["apiData"]) as T
                  : null,
              apiErrors: json["apiErrors"],
              apiStatus: json["apiStatus"],
              isSucceeded: json["isSucceeded"]);
        }

      case AddPlateIdentityDTO:
        {
          return ServerResponse(
              apiData: json["apiData"] != null
                  ? AddPlateIdentityDTO.fromJson(json["apiData"]) as T
                  : null,
              apiErrors: json["apiErrors"],
              apiStatus: json["apiStatus"],
              isSucceeded: json["isSucceeded"]);
        }

      case PlateIdentityDTO:
        {
          return ServerResponse(
              apiData: json["apiData"] != null
                  ? PlateIdentityDTO.fromJson(json["apiData"]) as T
                  : null,
              apiErrors: json["apiErrors"],
              apiStatus: json["apiStatus"],
              isSucceeded: json["isSucceeded"]);
        }

      case PaymentStatusDTO:
        {
          return ServerResponse(
              apiData: json["apiData"] != null
                  ? PaymentStatusDTO.fromJson(json["apiData"]) as T
                  : null,
              apiErrors: json["apiErrors"],
              apiStatus: json["apiStatus"],
              isSucceeded: json["isSucceeded"]);
        }

      default:
        return ServerResponse(
            apiData: null as T,
            apiErrors: json['apiErrors'] as List<dynamic>,
            apiStatus: json['apiStatus'] as int,
            isSucceeded: json['isSucceeded'] as bool);
    }
  }

  List<Object?> get props =>
      [this.apiData, this.apiErrors, this.apiStatus, this.isSucceeded];
}
