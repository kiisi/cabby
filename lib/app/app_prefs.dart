import 'package:shared_preferences/shared_preferences.dart';

const String prefsOnboardingScreen = "PREFS_ONBOARDING_SCREEN";
const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGEDIN";
const String prefsKeyAccessToken = "PREFS_KEY_ACCESS_TOKEN";
const String prefsKeyLatitude = "PREFS_KEY_LATITUDE";
const String prefsKeyLongitude = "PREFS_KEY_LONGITUDE";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(prefsOnboardingScreen, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(prefsOnboardingScreen) ?? false;
  }

  Future<void> setAccessToken(String? accessToken) async {
    _sharedPreferences.setString(prefsKeyAccessToken, accessToken ?? "");
  }

  Future<String> getAccessToken() async {
    return _sharedPreferences.getString(prefsKeyAccessToken) ?? "";
  }

  Future<void> setLatitude(double latitude) async {
    _sharedPreferences.setDouble(prefsKeyLatitude, latitude);
  }

  double getLatitude() {
    return _sharedPreferences.getDouble(prefsKeyLatitude) ?? 0;
  }

  Future<void> setLongitude(double longitude) async {
    _sharedPreferences.setDouble(prefsKeyLongitude, longitude);
  }

  double getLongitude() {
    return _sharedPreferences.getDouble(prefsKeyLongitude) ?? 0;
  }
}
