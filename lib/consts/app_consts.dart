import 'package:stylers_in_customer/config/size_config.dart';

class AppConsts {
  AppConsts._();

  static const String appName = 'StylersIn Customer';
  static const double tabFontFactor = 1.5;
  static const double mobileFontFactor = 1.0;

  static const String googleApiKey = "AIzaSyAaVnz03Xmd1cZGKPcVcKFHg0rAX4o_BAs";

  static double commonFontSizeFactor =
      SizeConfig.isMobile ? mobileFontFactor : tabFontFactor;

  static const String baseUrl = "";

  //false on release

  static const bool isLog = true;
  static const bool isDebug = true;

  static const double mapCameraTilt = 50.440717697143555;
  static const double mapCameraZoom = 19.151926040649414;

  //Data Transfer Keys
  static String keyIsEditAppointment = 'key_is_edit_appointment';
  static String keyEditAppointmentFrom = 'key_edit_appointment_from';
  static String keyFollowersListFrom = 'key_edit_appointment_from';
  static String keyMediaPath = 'key_media_path';
  static String keySignupFrom = 'key_signup_from';
  static String keyProviderId = 'key_provider_id';
  static String keySearchKeyword = 'key_search_keyword';
  static String keyPostId = 'key_post_id';
  static String keyMedia = 'key_media';
  static String keyProviderRole = 'key_provider_role';
  static String keyProviderProfileImage = 'key_provider_profile_image';
  static String keyProviderName = 'key_provider_name';
  static String keyStreetAddressLine1 = 'key_street_address_line_1';
  static String keyStreetAddressLine2 = 'key_street_address_line_2';
  static String keyLocation = 'key_location';
  static String keyAppointmentId = 'key_appointment_id';
}
