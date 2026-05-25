import 'package:shamsi_date/shamsi_date.dart';

class DateUtility {
  static String getCurrentDate() {
    var date = DateTime.now().toJalali();
    return "${date.year}/${date.month < 10 ? "0${date.month}" : date.month}/${date.day < 10 ? "0${date.day}" : date.day}";
  }

  static String getCurrentTime() {
    return "${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute} : ${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour}";
  }
}
