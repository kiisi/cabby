import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const _Initial(phoneNumber: "")) {
    on<AuthenticationEvent>((event, emit) {
      event.when(
        setPhoneNumber: (updatedPhoneNumber) {
          emit(_Initial(phoneNumber: updatedPhoneNumber));
        },
        processButtonPressed: () {},
      );
    });
  }
}
