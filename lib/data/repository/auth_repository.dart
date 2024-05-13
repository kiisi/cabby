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

  Future<Either<Failure, AuthenticationResponse>> getStartedUserInfo(
      GetStartedUserInfoRequest getStartedUserInfoRequest);

  Future<Either<Failure, AuthenticationResponse>> userAuth();
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
      return Left(FailureExceptionHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, AuthenticationResponse>> otpVerify(
      OtpVerifyRequest otpVerifyRequest) async {
    try {
      final response = await _authenticationRemoteDataSource
          .otpVerifyRequest(otpVerifyRequest);

      print("======RESPONSE======");
      print(response);
      print("======RESPONSE======");
      return Right(response);
    } catch (error) {
      print("=======ERROR========");
      print(error);
      print("=======ERROR========");
      return Left(FailureExceptionHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, AuthenticationResponse>> getStartedUserInfo(
      GetStartedUserInfoRequest getStartedUserInfoRequest) async {
    try {
      final response = await _authenticationRemoteDataSource
          .getStartedUserInfo(getStartedUserInfoRequest);
      return Right(response);
    } catch (error) {
      return Left(FailureExceptionHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, AuthenticationResponse>> userAuth() async {
    try {
      final response = await _authenticationRemoteDataSource.userAuth();
      return Right(response);
    } catch (error) {
      return Left(FailureExceptionHandler.handle(error).failure);
    }
  }
}
