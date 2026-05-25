import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/constance/strings.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:parkingandroid/features/common/data/data-source/local-data-source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonLocalDatasourceImpl extends CommonLocalDatasource {
  late SharedPreferences preferences;

  CommonLocalDatasourceImpl() {
    init();
  }

  void init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<Either<AppExceptions, bool>> saveUserInformation(
      {required String accessToken,
      required String refreshToken,
      required String uniqueIdentifier}) async {
    try {
      bool isSavedAccessToken =
          await preferences.setString(ACCESSTOKEN, accessToken);
      bool isSavedRefreshToken =
          await preferences.setString(REFRESHTOKEN, refreshToken);
      bool isSavedUniquIdentifier =
          await preferences.setString(UNIQUEIDENTIFIER, uniqueIdentifier);

      return Right(
          isSavedUniquIdentifier && isSavedAccessToken && isSavedRefreshToken);
    } catch (exception) {
      return Left(LocalException(message: exception.toString()));
    }
  }
}
