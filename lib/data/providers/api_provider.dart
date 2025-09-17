import 'package:cabby/app/app_config.dart';
import 'package:cabby/app/app_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  late Dio _dio;

  final AppPreferences _appPreferences;

  // Initialize Dio with default configs
  ApiProvider(this._appPreferences) {
    BaseOptions options = BaseOptions(
      baseUrl: AppConfig.apiUrl,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio = Dio(options);

    // Add request interceptor for auth token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get token from secure storage
          final token = await _appPreferences.getAccessToken();

          // If token exists, add it to the header
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (DioException error, handler) {
          // Log error if in debug mode
          if (kDebugMode) {
            print('API Error: ${error.message}');
            print('API Error Response: ${error.response?.data}');
          }

          return handler.next(error);
        },
      ),
    );
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Error handler
  Exception _handleError(DioException error) {
    String errorMessage = 'An error occurred';

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Connection timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        if (error.response != null) {
          // Try to get error message from response
          try {
            errorMessage = error.response?.data['message'] ?? 'Server error occurred';
          } catch (e) {
            errorMessage = 'Error code: ${error.response?.statusCode}';
          }
        } else {
          errorMessage = 'Server error occurred';
        }
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request was cancelled';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'No internet connection';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Bad certificate';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'Unknown error occurred';
        break;
    }

    return Exception(errorMessage);
  }
}
