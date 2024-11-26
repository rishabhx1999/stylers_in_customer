import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:stylers_in_customer/model/device_info/device_model.dart';


class DeviceConfig {
  static DeviceModel? deviceDetails = DeviceModel();

  static Future<bool> init() async {
    /*   DeviceConfig.getDeviceInfo().then((value) {
      deviceDetails = value;
    });*/
    DeviceConfig.getDeviceInfo().then((value) async {
      deviceDetails = value;

      // debugPrint{(res1.toString());
/*
      _loginController.masterCallback(res1);
      if (PreferencesManager.isUserLoggedIn()) {
        _loginController.masterCallback(res1);
        if (await Helpers.isInternetConnection() == false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Utils.showLoader();
            _loginController.CheckNavigatingScreen()
                .then((value) => Timer(Duration(seconds: 2), () {
                      Utils.hideLoader();
                    }));
          });
        }
      }
*/
    });
    return Future.value(true);
  }

  static Future<DeviceModel> getDeviceInfo() async {
    DeviceModel deviceDetails = DeviceModel();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo info = await deviceInfo.androidInfo;
        deviceDetails.deviceName = info.model;
        deviceDetails.deviceOS = "Android";
        deviceDetails.deviceOSVersion = info.version.sdkInt.toString();
        deviceDetails.deviceModel = info.model;
        deviceDetails.deviceId = info.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo info = await deviceInfo.iosInfo;
        deviceDetails.deviceName = info.utsname.machine;
        deviceDetails.deviceOS = "iOS";
        deviceDetails.deviceOSVersion = info.systemName;
        deviceDetails.deviceModel = info.utsname.machine;
        deviceDetails.deviceId = info.identifierForVendor;

        // uniq
      }
    } catch (e) {}
    return deviceDetails;
  }
}
