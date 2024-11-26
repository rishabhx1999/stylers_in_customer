import 'package:get/get_utils/get_utils.dart';
import 'package:permission_handler/permission_handler.dart';

import '../views/dialogs/common/common_alert_dialog.dart';

class PermissionHandler {
  static Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      CommonAlertDialog.showDialog(
          title: 'allow_permissions'.tr,
          message: 'go_to_settings'.tr,
          positiveText: 'open_settings'.tr,
          positiveBtCallback: () async {
            await openAppSettings();
          });
    } else {
      var status = await Permission.camera.request();
      if (status == PermissionStatus.permanentlyDenied) {
        CommonAlertDialog.showDialog(
            title: 'allow_permissions'.tr,
            message: 'go_to_settings'.tr,
            positiveText: 'open_settings'.tr,
            positiveBtCallback: () async {
              await openAppSettings();
            });
      }
    }
    return false;
  }

  static Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      showInstructionsDialog();
    } else {
      var status = await Permission.location.request();

      if (status == PermissionStatus.granted) {
        return true;
      } else {
        showInstructionsDialog();
      }
    }
    return false;
  }
}

void showInstructionsDialog() {
  CommonAlertDialog.showDialog(
      title: 'allow_permissions'.tr,
      message: 'go_to_settings'.tr,
      positiveText: 'open_settings'.tr,
      positiveBtCallback: () async {
        await openAppSettings();
      });
}
