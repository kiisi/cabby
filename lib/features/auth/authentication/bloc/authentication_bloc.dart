import 'package:bloc/bloc.dart';
import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/data/request/auth_request.dart';
import 'package:cabby/domain/usecases/auth_usecase.dart';
import 'package:cabby/core/common/form_submission_status.dart';
import 'package:flutter/cupertino.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetStartedUseCase _getStartedUseCase = getIt<GetStartedUseCase>();

  final AppPreferences _appPreferences = getIt<AppPreferences>();

  AuthenticationBloc() : super(AuthenticationState()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationSetPhoneNumber) {
        emit(state.copyWith(
          phoneNumber: event.phoneNumber,
          formStatus: const FormInitialStatus(),
        ));
      } else if (event is AuthenticationSetEmail) {
        emit(state.copyWith(
          email: event.email,
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

        _appPreferences.setUserEmail(state.email ?? '');
        _appPreferences.setUserPhoneNumber(int.parse(state.phoneNumber ?? '0'));
        _appPreferences.setUserCountryCode(state.countryCode);

        (await _getStartedUseCase.execute(
          GetStartedRequest(
            countryCode: state.countryCode,
            email: state.email ?? '',
            phoneNumber: state.phoneNumber ?? '',
          ),
        ))
            .fold(
          (failure) {
            emit(state.copyWith(
                formStatus: FormSubmissionFailed(message: failure.message)));
          },
          (success) => {
            emit(state.copyWith(
                formStatus: FormSubmissionSuccess(message: success.message))),
          },
        );
      }
    });
  }
}
