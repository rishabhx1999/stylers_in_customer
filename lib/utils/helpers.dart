import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import '../consts/app_consts.dart';
import '../network/ApiUrls.dart';

class Helpers {
  Helpers._();

  static printLog({required String screenName, required String message}) {
    if (AppConsts.isDebug) debugPrint("$screenName ==== $message");
  }

  static bool isResponseSuccessful(int code) {
    return code >= 200 && code < 300;
  }

  static String getImgUrl(String url) {
    debugPrint("url ======= = $url");

    if (url.startsWith('http')) {
      return url;
    } else {
      return ApiUrls.baseUrlImage + url;
    }
  }

  static Future<String> getCityName(double latitude, double longitude) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemark.isNotEmpty) {
      if (placemark[0].subAdministrativeArea != null &&
          placemark[0].subAdministrativeArea!.isNotEmpty) {
        return placemark[0].subAdministrativeArea!;
      } else if (placemark[0].locality != null && placemark[0].locality!.isNotEmpty) {
        return placemark[0].locality!;
      } else if (placemark[0].subLocality != null &&
          placemark[0].subLocality!.isNotEmpty) {
        return placemark[0].subLocality!;
      } else {
        return placemark[0].country ?? '';
      }
    }
    return "City";
  }

  static String convertToTimeSlotFormat(String? startTime, String? endTime) {
    if (startTime == null ||
        startTime == '' ||
        endTime == '' ||
        endTime == null) {
      return '';
    } else {
      StringBuffer timeSlot = StringBuffer();

      timeSlot.write(twelveHourTimeFormat(startTime));
      timeSlot.write(' - ');
      timeSlot.write(twelveHourTimeFormat(endTime));

      return timeSlot.toString();
    }
  }

  static String twelveHourTimeFormat(String? time) {
    if (time != null) {
      if (time.contains(':')) {
        List<String> splitTime = time.split(':');
        int hour = int.parse(splitTime.first);
        if (hour <= 12) {
          return '$hour:${splitTime[1]} am';
        } else {
          return '${hour - 12}:${splitTime[1]} pm';
        }
      }
      return '';
    } else {
      return '';
    }
  }
}
