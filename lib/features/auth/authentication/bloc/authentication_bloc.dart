import 'package:bloc/bloc.dart';
import 'package:cabby/data/request/auth_request.dart';
import 'package:cabby/domain/usecases/auth_usecase.dart';
import 'package:cabby/core/common/form_submission_status.dart';
import 'package:flutter/cupertino.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetStartedUseCase _getStartedUseCase;

  AuthenticationBloc(this._getStartedUseCase) : super(AuthenticationState()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationSetPhoneNumber) {
        emit(state.copyWith(
          phoneNumber: event.phoneNumber,
          formStatus: const FormInitialStatus(),
        ));
      } else if (event is AuthenticationSetCountryCode) {
        emit(state.copyWith(
          countryCode: event.countryCode,
          formStatus: const FormInitialStatus(),
        ));
      } else if (event is AuthenticationSubmission) {
        emit(state.copyWith(
          formStatus: FormSubmitting(),
        ));

        (await _getStartedUseCase.execute(
          GetStartedRequest(
            countryCode: state.countryCode,
            phoneNumber: state.phoneNumber ?? '',
          ),
        ))
            .fold(
          (failure) {
            print("====Failure Error =====");
            print("Failure $failure");
            emit(state.copyWith(
                formStatus: FormSubmissionFailed(message: failure.message)));
          },
          (success) => {
            print('Success $success'),
            emit(state.copyWith(
                formStatus: FormSubmissionSuccess(message: success.message))),
          },
        );
      }
    });
  }
}
