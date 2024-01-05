import 'package:cabby/data/data_source/auth_remote_data_source.dart';
import 'package:cabby/data/network/failure.dart';
import 'package:cabby/data/request/auth_request.dart';
import 'package:cabby/data/responses/responses.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthenticationRepository {
  Future<Either<Failure, AuthenticationResponse>> getStarted(
      GetStartedRequest getStartedRequest);

  Future<Either<Failure, AuthenticationResponse>> otpVerify(
      OtpVerifyRequest otpVerifyRequest);
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;

  AuthenticationRepositoryImpl(this._authenticationRemoteDataSource);

  @override
  Future<Either<Failure, AuthenticationResponse>> getStarted(
      GetStartedRequest getStartedRequest) async {
    try {
      final response =
          await _authenticationRemoteDataSource.getStarted(getStartedRequest);
      return Right(response);
    } catch (error) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, AuthenticationResponse>> otpVerify(
      OtpVerifyRequest otpVerifyRequest) async {
    try {
      final response = await _authenticationRemoteDataSource
          .otpVerifyRequest(otpVerifyRequest);
      return Right(response);
    } catch (error) {
      print('optVerif Impl Error: $error');
      return Left(Failure());
    }
  }
}
