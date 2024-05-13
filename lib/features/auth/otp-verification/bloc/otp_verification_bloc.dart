import 'package:bloc/bloc.dart';
import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/common/form_submission_status.dart';
import 'package:cabby/data/request/auth_request.dart';
import 'package:cabby/domain/usecases/auth_usecase.dart';
import 'package:flutter/material.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  final OtpVerifyUseCase _otpVerifyUseCase;
  final AppPreferences _appPreferences = getIt<AppPreferences>();

  OtpVerificationBloc(this._otpVerifyUseCase) : super(OtpVerificationState()) {
    on<OtpVerificationEvent>((event, emit) async {
      if (event is OtpVerificationSetOtp) {
        emit(state.copyWith(
          otp: event.otp,
          formStatus: const FormInitialStatus(),
        ));
      } else if (event is OtpVerificationSubmission) {
        emit(state.copyWith(
          formStatus: FormSubmitting(),
        ));

        (await _otpVerifyUseCase.execute(
          OtpVerifyRequest(
            otp: state.otp ?? '',
            email: _appPreferences.getUserEmail(),
          ),
        ))
            .fold(
          (failure) {
            print("Failure ${failure.message}");
            emit(
              state.copyWith(
                formStatus: FormSubmissionFailed(
                  message: failure.message,
                ),
              ),
            );
          },
          (success) {
            _appPreferences
                .setUserFirstName(success.data?.user?.firstName ?? '');
            _appPreferences.setUserLastName(success.data?.user?.lastName ?? '');
            _appPreferences.setUserGender(success.data?.user?.gender ?? '');

            emit(
              state.copyWith(
                formStatus: FormSubmissionSuccess(
                  message: success.message,
                  data: success.data,
                ),
              ),
            );
          },
        );
      }
    });
  }
}
