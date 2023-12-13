import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLang = "PREFS_KEY_LANG";
const String prefsOnboardingScreen = "PREFS_ONBOARDING_SCREEN";
const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGEDIN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);
}
