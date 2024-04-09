import 'package:cabby/data/network/network_exceptions.dart';

class Failure {
  int statusCode;
  String message;

  Failure({required this.statusCode, required this.message});
}

class FailureExceptionHandler implements Exception {
  late Failure failure;

  FailureExceptionHandler.handle(dynamic error) {
    failure = Failure(
      statusCode: NetworkExceptions.getDioStatus(error),
      message: NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(error),
      ),
    );
  }
}

class BadResponse {
  final String? message;
  final int? errorCode;

  BadResponse({this.message, this.errorCode});

  factory BadResponse.fromJson(Map<String, dynamic> json) {
    return BadResponse(
      message: json['message'],
      errorCode: json['error_code'],
    );
  }
}
