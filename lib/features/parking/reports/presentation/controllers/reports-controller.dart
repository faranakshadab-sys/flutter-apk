import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';

import '../../../common/domain/models/report-view-model.dart';
import '../../../common/domain/use-cases/get-reports-case.dart';

class ReportsController extends GetxController {
  final GetReportsCase getReportsCase;

  ReportsController({required this.getReportsCase});

  bool loading = true;
  List<ReportViewModel> reports = [];
  int page = 1;
  int pageSize = 10;

  String plateNumber1 = "";
  String plateNumber2 = "";
  String plateNumber3 = "";
  String plateNumber4 = "";

  bool showFab = false;
  bool isDataEnded = false;

  bool get isSearchVisible =>
      plateNumber1 != "" ||
      plateNumber2 != "" ||
      plateNumber3 != "" ||
      plateNumber4 != "";

  void checkSearchInputValues() {
    if (plateNumber1 == "" &&
        plateNumber2 == "" &&
        plateNumber3 == "" &&
        plateNumber4 == "") {
      reports = [];
      page = 1;
      getReports();
    }
  }

  void onChangePlateNumber1(String value) {
    plateNumber1 = value;
    update();
    checkSearchInputValues();
  }

  void onChangePlateNumber2(String value) {
    plateNumber2 = value;
    update();
    checkSearchInputValues();
  }

  void onChangePlateNumber3(String value) {
    plateNumber3 = value;
    update();
    checkSearchInputValues();
  }

  void onChangePlateNumber4(String value) {
    plateNumber4 = value;
    update();
    checkSearchInputValues();
  }

  void handleSearchButton() async {
    reports = [];
    page = 1;
    getReports();
  }

  void updateFabStatus(bool value) {
    showFab = value;
    update();
  }

  Future getReports() async {
    var response = await getReportsCase(
        params: GetReportsCaseParams(
            page: page,
            pageSize: pageSize,
            date: "",
            plateNumberPart1: plateNumber1 == "" ? 0 : int.parse(plateNumber1),
            plateNumberPart2: plateNumber2,
            plateNumberPart3: plateNumber3 == "" ? 0 : int.parse(plateNumber3),
            plateNumberPart4:
                plateNumber4 == "" ? 0 : int.parse(plateNumber4)));

    response.fold(
        (failure) => SnackbarUtility.showSnackbar(message: failure.message),
        (success) {
      reports.addAll(success);
      loading = false;

      if (success.length < 10) {
        isDataEnded = true;
      }

      page++;
      update();
    });
  }
}
