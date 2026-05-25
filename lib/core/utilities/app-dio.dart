import 'package:dio/dio.dart';
import 'package:parkingandroid/core/constance/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDio {
  static late Dio instance;

  static Future init({required String url}) async {
    instance = Dio();

    instance.options.baseUrl = url;

    instance.interceptors.addAll([AuthInterceptor()]);
  }
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    String? token = preferences.getString(ACCESSTOKEN);

    if (token != null) {
      options.headers['Authorization'] = token;
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    handler.next(err);
  }
}
