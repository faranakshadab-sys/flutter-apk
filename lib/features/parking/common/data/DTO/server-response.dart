import 'package:parkingandroid/features/parking/home/data/DTO/create-enter-report-dto.dart';
import 'package:parkingandroid/features/parking/home/data/DTO/submit-exit-report-dto.dart';
import 'package:parkingandroid/features/parking/reports/data/DTO/report-information-dto.dart';
import 'package:parkingandroid/features/parking/authentication/data/DTO/login-dto.dart';
import 'package:parkingandroid/features/parking/home/data/DTO/profile-dto.dart';
import 'package:parkingandroid/features/parking/home/data/DTO/report-dto.dart';
import '../../../home/data/DTO/detected-plate-dto.dart';
import 'add-plate-identity-dto.dart';
import 'payment-status-dto.dart';
import 'plate-identity-dto.dart';
import 'reports-dto.dart';

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

      case Report:
        {
          return ServerResponse(
              apiData: json["apiData"] != null
                  ? Report.fromJson(json["apiData"]) as T
                  : null,
              apiErrors: json["apiErrors"],
              apiStatus: json["apiStatus"],
              isSucceeded: json["isSucceeded"]);
        }

      case DetectedPlateDTO:
        {
          return ServerResponse(
              apiData: json["apiData"] != null
                  ? DetectedPlateDTO.fromJson(json["apiData"]) as T
                  : null,
              apiErrors: json["apiErrors"],
              apiStatus: json["apiStatus"],
              isSucceeded: json["isSucceeded"]);
        }

      case CreateEnterReportDTO:
        {
          return ServerResponse(
              apiData: json["apiData"] != null
                  ? CreateEnterReportDTO.fromJson(json["apiData"]) as T
                  : null,
              apiErrors: json["apiErrors"],
              apiStatus: json["apiStatus"],
              isSucceeded: json["isSucceeded"]);
        }

      case SubmitExitReportDTO:
        {
          return ServerResponse(
              apiData: json["apiData"] != null
                  ? // SubmitExitReportDTO.fromJson(json["apiData"]) as T
                  null
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
