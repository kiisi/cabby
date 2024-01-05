import 'package:cabby/data/network/failure.dart';
import 'package:cabby/data/repository/auth_repository.dart';
import 'package:cabby/data/request/auth_request.dart';
import 'package:cabby/data/responses/responses.dart';
import 'package:cabby/domain/usecases/base_usecase.dart';
import 'package:dartz/dartz.dart';

class GetStartedUseCase
    implements BaseUseCase<GetStartedRequest, AuthenticationResponse> {
  final AuthenticationRepository _authenticationRepository;

  GetStartedUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, AuthenticationResponse>> execute(
      GetStartedRequest input) async {
    return await _authenticationRepository.getStarted(input);
  }
}

class OtpVerifyUseCase
    implements BaseUseCase<OtpVerifyRequest, AuthenticationResponse> {
  final AuthenticationRepository _authenticationRepository;

  OtpVerifyUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, AuthenticationResponse>> execute(
      OtpVerifyRequest input) async {
    return await _authenticationRepository.otpVerify(input);
  }
}
