import 'package:get/get.dart';

import '../../utils/preference_manager.dart';

class InboxController extends GetxController {
  RxString profileImage = "".obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    getUserDataFromPref();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getUserDataFromPref() {
    isLoggedIn.value =
        (PreferenceManager.getPref(PreferenceManager.prefIsLogin) as bool?) ??
            false;
    profileImage.value =
        (PreferenceManager.getPref(PreferenceManager.prefUserImage)
                as String?) ??
            '';
  }
}
