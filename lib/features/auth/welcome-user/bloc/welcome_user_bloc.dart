import 'package:bloc/bloc.dart';
import 'package:cabby/core/common/form_submission_status.dart';
import 'package:cabby/data/request/auth_request.dart';
import 'package:cabby/domain/usecases/auth_usecase.dart';
import 'package:meta/meta.dart';

part 'welcome_user_event.dart';
part 'welcome_user_state.dart';

class WelcomeUserBloc extends Bloc<WelcomeUserEvent, WelcomeUserState> {
  final GetStartedUserInfoUseCase _getStartedUserInfoUseCase;
  final String phoneNumber;
  final String countryCode;
  WelcomeUserBloc(this._getStartedUserInfoUseCase,
      {required this.phoneNumber, required this.countryCode})
      : super(WelcomeUserState()) {
    on<WelcomeUserEvent>((event, emit) async {
      if (event is WelcomeUserSetFirstName) {
        emit(state.copyWith(
            firstName: event.firstName, formStatus: const FormInitialStatus()));
      } else if (event is WelcomeUserSetLastName) {
        emit(state.copyWith(
            lastName: event.lastName, formStatus: const FormInitialStatus()));
      } else if (event is WelcomeUserSetGender) {
        emit(state.copyWith(
            gender: event.gender, formStatus: const FormInitialStatus()));
      } else if (event is WelcomeUserSubmission) {
        emit(state.copyWith(formStatus: FormSubmitting()));
        (await _getStartedUserInfoUseCase.execute(
          GetStartedUserInfoRequest(
            countryCode: countryCode,
            phoneNumber: phoneNumber,
            firstName: state.firstName ?? '',
            lastName: state.lastName ?? '',
            gender: state.gender ?? '',
          ),
        ))
            .fold((failure) {
          print("Failure ${failure.message}");
          emit(
            state.copyWith(
              formStatus: FormSubmissionFailed(
                message: failure.message,
              ),
            ),
          );
        }, (success) {
          print('Success $success');
          emit(
            state.copyWith(
              formStatus: FormSubmissionSuccess(
                message: success.message,
                data: success.data,
              ),
            ),
          );
        });
      }
    });
  }
}
