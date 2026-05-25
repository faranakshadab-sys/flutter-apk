import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';
import '../../../common/domain/models/plate-identity-model.dart';
import '../../../common/domain/use-cases/add-plate-identity-case.dart';
import '../../../common/domain/use-cases/get-plate-identities-case.dart';
import '../../../common/domain/use-cases/submit-payment-status-case.dart';
import '../../domain/model/report-information-model.dart';
import '../../domain/use-cases/report-information-case.dart';

class ReportInformationController extends GetxController {
  final ReportInformationCase reportInformationCase;

  final AddPlateIdentityCase addPlateIdentityCase;
  final GetPlateIdentitiesCase getPlateIdentitiesCase;
  final SubmitPaymentStatusCase submitPaymentStatusCase;
  final int reportId;

  ReportInformationController(
      {required this.reportInformationCase,
      required this.addPlateIdentityCase,
      required this.getPlateIdentitiesCase,
      required this.submitPaymentStatusCase,
      required this.reportId});

  bool loading = true;

  ReportInformationModel? reportInformation;

  String initialPlateNumber1 = "";
  String initialPlateNumber2 = "";
  String initialPlateNumber3 = "";
  String initialPlateNumber4 = "";

  String plateNumber1 = "";
  String plateNumber2 = "";
  String plateNumber3 = "";
  String plateNumber4 = "";

  bool get isEditedPlateNumber =>
      plateNumber1 != initialPlateNumber1 ||
      plateNumber2 != initialPlateNumber2 ||
      plateNumber3 != initialPlateNumber3 ||
      plateNumber4 != initialPlateNumber4;

  bool isDataChanged = false;

  List<PlateIdentityModel> phones = [];

  void updatePlateNumber1(String value) {
    plateNumber1 = value;
    update();
  }

  void updatePlateNumber2(String value) {
    plateNumber2 = value;
    update();
  }

  void updatePlateNumber3(String value) {
    plateNumber3 = value;
    update();
  }

  void updatePlateNumber4(String value) {
    plateNumber4 = value;
    update();
  }

  void _resetDataChange() {
    Future.delayed(Duration(seconds: 1), () {
      isDataChanged = false;
    });
  }

  Future getReportInformation() async {
    var response = await reportInformationCase(
        params: ReportInformationCaseParams(reportId: reportId));

    response.fold((failure) {
      SnackbarUtility.showSnackbar(message: failure.message);
    }, (success) async {
      reportInformation = success;

      plateNumber1 = success.plateNumberPart1.toString();
      plateNumber2 = success.plateNumberPart2;
      plateNumber3 = success.plateNumberPart3.toString();
      plateNumber4 = success.plateNumberPart4.toString();

      initialPlateNumber1 = success.plateNumberPart1.toString();
      initialPlateNumber2 = success.plateNumberPart2.toString();
      initialPlateNumber3 = success.plateNumberPart3.toString();
      initialPlateNumber4 = success.plateNumberPart4.toString();

      isDataChanged = true;

      getPlateIdentities(
          plateNumber1: success.plateNumberPart1,
          plateNumber2: success.plateNumberPart2,
          plateNumber3: success.plateNumberPart3,
          plateNumber4: success.plateNumberPart4);

      update();
      _resetDataChange();
    });
  }

  void getPlateIdentities(
      {required int plateNumber1,
      required String plateNumber2,
      required int plateNumber3,
      required int plateNumber4}) async {
    var response = await getPlateIdentitiesCase(
        params: GetPlateIdentitiesCaseParams(
            page: 1,
            pageSize: 100,
            plateNumberPart1: plateNumber1,
            plateNumberPart2: plateNumber2,
            plateNumberPart3: plateNumber3,
            plateNumberPart4: plateNumber4));

    response.fold(
        (failure) => SnackbarUtility.showSnackbar(message: failure.message),
        (success) {
      phones = success;
      loading = false;
      update();
    });
  }

  Future<bool> addPlateIdentity(String phoneNumber) async {
    var response = await addPlateIdentityCase(
        params: AddPlateIdentityCaseParams(
            plateNumberPart1: int.parse(plateNumber1),
            ownerMobileNumber: phoneNumber,
            plateNumberPart2: plateNumber2,
            plateNumberPart3: int.parse(plateNumber3),
            plateNumberPart4: int.parse(plateNumber4)));

    return response.fold((failure) {
      SnackbarUtility.showSnackbar(message: failure.message);
      return false;
    }, (success) {
      SnackbarUtility.showSnackbar(message: "request-success-message".tr);
      getPlateIdentities(
          plateNumber1: int.parse(plateNumber1),
          plateNumber2: plateNumber2,
          plateNumber3: int.parse(plateNumber3),
          plateNumber4: int.parse(plateNumber4));
      return true;
    });
  }

  Future<bool> submitPaymentStatus(
      {required int reportId,
      required int totalAmount,
      required String referenceId}) async {
    var response = await submitPaymentStatusCase(
        params: SubmitPaymentStatusCaseParams(
            reportId: reportId,
            totalAmount: totalAmount,
            referenceId: referenceId));

    return response.fold((failure) {
      SnackbarUtility.showSnackbar(message: failure.message);
      return false;
    }, (success) {
      if (success) {
        SnackbarUtility.showSnackbar(message: "request-success-message".tr);
        return true;
      } else {
        SnackbarUtility.showSnackbar(message: "request-failed-response".tr);
        return false;
      }
    });
  }
}
