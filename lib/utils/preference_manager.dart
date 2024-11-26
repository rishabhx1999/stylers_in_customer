import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const prefIsLogin = 'pref_key_is_user_login';
  static const prefIsFirstLaunch = 'pref_key_is_first_launch';
  static const prefUserToken = 'pref_key_user_token';
  static const prefIsRememberMe = 'pref_key_is_remember_me';
  static const prefIsVisitor = 'pref_key_is_visitor';
  static const prefUserFirstName = 'pref_key_user_first_name';
  static const prefUserLastName = 'pref_key_user_last_name';
  static const prefUserEmail = 'pref_key_user_email';
  static const prefUserPassword = 'pref_key_user_password';
  static const prefUsername = 'pref_key_username';
  static const prefUserMobile = 'pref_mobile';
  static const prefCountryCode = 'pref_country_code';
  static const prefUserId = 'pref_user_id';
  static const prefUserImage = 'pref_user_image';
  static const prefUserAddress = 'pref_user_address';
  static const prefUserCity = 'pref_user_city';
  static const prefUserPostalCode = 'pref_user_postal_code';
  static const prefUserProvince = 'pref_user_province';

  static late SharedPreferences _prefs;

  PreferenceManager._();

  static Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  static Future<bool> init() async {
    _prefs = await _getInstance();
    return Future.value(true);
  }

  static void save2Pref(String key, dynamic value) {
    if (value is bool) {
      _prefs.setBool(key, value);
    } else if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is double) {
      _prefs.setDouble(key, value);
    } else if (value is String) {
      _prefs.setString(key, value);
    } else {
      //throw Exception("Attempting to save non-primitive preference");
    }
  }

  static Object? getPref(String key) {
    return _prefs.get(key);
  }

  static bool isUserLoggedIn() {
    bool? isLogin = getPref(prefIsLogin) as bool?;
    return isLogin ?? false;
  }

  static bool isUserRemembered() {
    bool? isRemember = getPref(prefIsRememberMe) as bool?;
    return isRemember ?? false;
  }

  static bool isFirstTimeLaunch() {
    bool? isFirstLaunch = getPref(prefIsFirstLaunch) as bool?;
    return isFirstLaunch ?? true;
  }

  static bool isUserVisitor() {
    bool? isVisitor = getPref(prefIsVisitor) as bool?;
    return isVisitor ?? false;
  }

  static void clean() {
    _prefs.clear();
  }

  static void removeBasicData() {
    _prefs.remove(prefUserToken);
    _prefs.remove(prefUserFirstName);
    _prefs.remove(prefUserLastName);
    _prefs.remove(prefUsername);
    _prefs.remove(prefUserMobile);
    _prefs.remove(prefUserId);
  }

  static void removeEmailPassword() {
    _prefs.remove(prefUserEmail);
    _prefs.remove(prefUserPassword);
  }

  static void remove(String key) {
    _prefs.remove(key);
  }
}
