import 'package:bloc/bloc.dart';
import 'package:cabby/core/common/form_submission_status.dart';
import 'package:meta/meta.dart';

part 'welcome_user_event.dart';
part 'welcome_user_state.dart';

class WelcomeUserBloc extends Bloc<WelcomeUserEvent, WelcomeUserState> {
  WelcomeUserBloc() : super(WelcomeUserState()) {
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
        await Future.delayed(const Duration(seconds: 2));
        emit(state.copyWith(formStatus: FormSubmissionSuccess()));
      }
    });
  }
}
