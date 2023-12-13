import 'dart:convert';

import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = "application/json";
const String contentType = "Content-Type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

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

    dio.interceptors.add(JsonResponseInterceptor());

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

class JsonResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    response.data = json.decode(response.data);
    super.onResponse(response, handler);
  }
}
