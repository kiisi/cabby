part of 'welcome_user_bloc.dart';

@immutable
abstract class WelcomeUserEvent {}

class WelcomeUserSetFirstName extends WelcomeUserEvent {
  final String? firstName;
  WelcomeUserSetFirstName({this.firstName});
}

class WelcomeUserSetLastName extends WelcomeUserEvent {
  final String? lastName;
  WelcomeUserSetLastName({this.lastName});
}

class WelcomeUserSetGender extends WelcomeUserEvent {
  final String? gender;
  WelcomeUserSetGender({this.gender});
}

class WelcomeUserSetCountryCode extends WelcomeUserEvent {
  final String? countryCode;
  WelcomeUserSetCountryCode({this.countryCode});
}

class WelcomeUserSetPhoneNumber extends WelcomeUserEvent {
  final String? phoneNumber;
  WelcomeUserSetPhoneNumber({this.phoneNumber});
}

class WelcomeUserSubmission extends WelcomeUserEvent {}
