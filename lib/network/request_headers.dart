import '../utils/preference_manager.dart';

class RequestHeaders {
  static Map<String, String> getAcceptJsonHeader() {
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    return headers;
  }

  static Map<String, String> getAcceptAndContentType({bool token = true}) {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json;charset=utf-8"
    };
    if (token == true) {
      headers = addToken(headers);
    }
    return headers;
  }

  static Map<String, String> addToken(Map<String, String> headers) {
    String? bearerToken =
        PreferenceManager.getPref(PreferenceManager.prefUserToken) as String?;
    if (bearerToken != null) {
      headers.addAll({"Authorization": "Bearer $bearerToken"});
    }
    return headers;
  }
}
