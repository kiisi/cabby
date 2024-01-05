import 'package:bloc/bloc.dart';
import 'package:cabby/core/common/form_submission_status.dart';
import 'package:cabby/data/request/auth_request.dart';
import 'package:cabby/domain/usecases/auth_usecase.dart';
import 'package:flutter/material.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  final OtpVerifyUseCase _otpVerifyUseCase;
  final String phoneNumber;
  final String countryCode;
  OtpVerificationBloc(this._otpVerifyUseCase,
      {required this.phoneNumber, required this.countryCode})
      : super(OtpVerificationState()) {
    on<OtpVerificationEvent>((event, emit) async {
      print(countryCode);
      print(phoneNumber);
      if (event is OtpVerificationSetOtp) {
        emit(state.copyWith(
          otp: event.otp,
          formStatus: const FormInitialStatus(),
        ));
      } else if (event is OtpVerificationSubmission) {
        emit(state.copyWith(formStatus: FormSubmitting()));

        (await _otpVerifyUseCase.execute(
          OtpVerifyRequest(
            countryCode: countryCode,
            phoneNumber: phoneNumber,
            otp: state.otp ?? '',
          ),
        ))
            .fold(
          (failure) => {
            print("Failure $failure"),
            emit(state.copyWith(formStatus: FormSubmissionFailed()))
          },
          (success) => {
            print('Success $success'),
            emit(
              state.copyWith(
                formStatus: FormSubmissionSuccess(
                  message: success.message,
                  data: success.data,
                ),
              ),
            ),
          },
        );
      }
    });
  }
}
