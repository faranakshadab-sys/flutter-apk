import 'package:parkingandroid/core/constance/strings.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local-data-source.dart';

class AuthenticationLocalDatasourceImpl extends AuthenticationLocalDatasource {
  late SharedPreferences preferences;

  AuthenticationLocalDatasourceImpl() {
    init();
  }

  void init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<Either<AppExceptions, bool>> saveUserInformation({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      bool isSavedAccessToken =
          await preferences.setString(ACCESSTOKEN, accessToken);
      bool isSavedRefreshToken =
          await preferences.setString(REFRESHTOKEN, refreshToken);
   

      return Right(
           isSavedAccessToken && isSavedRefreshToken);
    } catch (exception) {
      return Left(LocalException(message: exception.toString()));
    }
  }
}
