import 'package:get/get.dart';

import '../../utils/preference_manager.dart';

class VerificationSuccessController extends GetxController {
  RxString name = ''.obs;

  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  void getUserName() {
    name.value =
        '${PreferenceManager.getPref(PreferenceManager.prefUserFirstName).toString()} ${PreferenceManager.getPref(PreferenceManager.prefUserLastName).toString()}';
  }
}
