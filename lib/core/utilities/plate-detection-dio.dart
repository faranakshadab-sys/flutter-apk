import 'package:dio/dio.dart';
import 'package:parkingandroid/core/constance/strings.dart';

class PlateDetectionDio {
  static late Dio instance;

  static Future init() async {
    instance = Dio();

    instance.options.baseUrl = LOCALPLATEDETECTIONDOMAIN;

    instance.interceptors.addAll([AuthInterceptor()]);
  }
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
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
