import 'package:cabby/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = "application/json";
const String contentType = "Content-Type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  DioFactory();

  Future<Dio> getDio() async {
    Dio dio = Dio();
    const Duration timeout = Duration(milliseconds: 60 * 1000);
    String language = "en";

    Map<String, dynamic>? headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constant.token,
      defaultLanguage: language
    };

    // dio.interceptors.add(NetworkConnectivityInterceptor());

    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        headers: headers);

    if (kReleaseMode) {
    } else {
      dio.interceptors.add(PrettyDioLogger(
          requestBody: true, requestHeader: true, responseBody: true));
    }

    return dio;
  }
}

class NetworkConnectivityInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);

    if (await InternetConnectionChecker().hasConnection) {
      handler.next(options);
    } else {
      throw DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
        error: "Error: No internet connection",
        message: "No internet connection",
      );
    }
  }
}
