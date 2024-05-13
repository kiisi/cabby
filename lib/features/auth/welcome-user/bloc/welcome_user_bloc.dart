import 'package:bloc/bloc.dart';
import 'package:cabby/app/app_prefs.dart';
import 'package:cabby/app/di.dart';
import 'package:cabby/core/common/form_submission_status.dart';
import 'package:cabby/data/request/auth_request.dart';
import 'package:cabby/domain/usecases/auth_usecase.dart';
import 'package:meta/meta.dart';

part 'welcome_user_event.dart';
part 'welcome_user_state.dart';

class WelcomeUserBloc extends Bloc<WelcomeUserEvent, WelcomeUserState> {
  final GetStartedUserInfoUseCase _getStartedUserInfoUseCase;
  final AppPreferences _appPreferences = getIt<AppPreferences>();
  WelcomeUserBloc(this._getStartedUserInfoUseCase) : super(WelcomeUserState()) {
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
            firstName: state.firstName ?? '',
            lastName: state.lastName ?? '',
            gender: state.gender ?? '',
            email: _appPreferences.getUserEmail(),
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

          _appPreferences.setUserFirstName(success.data?.user?.firstName ?? '');
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
        });
      }
    });
  }
}
