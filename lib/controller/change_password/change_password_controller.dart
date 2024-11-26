import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_routes.dart';
import '../../network/post_requests.dart';
import '../../utils/preference_manager.dart';

class ChangePasswordController extends GetxController {
  late final TextEditingController currentPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController againNewPasswordController;
  final formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    againNewPasswordController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void validatePageData() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      changePassword();
    }
  }

  void changePassword() async {
    var requestBody = {
      'current_password': currentPasswordController.text.trim(),
      'new_password': newPasswordController.text.trim()
    };
    isLoading.value = true;
    var response = await PostRequests.changePassword(requestBody);
    isLoading.value = false;
    if (response != null) {
      if (response.success) {
        removePrefData();
        Get.offAllNamed(AppRoutes.routePasswordChanged);
      } else {
        Get.snackbar('error'.tr, response.message);
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
  }

  void removePrefData() {
    PreferenceManager.save2Pref(PreferenceManager.prefIsLogin, false);
    PreferenceManager.save2Pref(PreferenceManager.prefUserFirstName, null);
    PreferenceManager.save2Pref(PreferenceManager.prefUserLastName, null);
    PreferenceManager.save2Pref(PreferenceManager.prefUsername, null);
    PreferenceManager.save2Pref(PreferenceManager.prefUserEmail, null);
    PreferenceManager.save2Pref(PreferenceManager.prefUserMobile, null);
    PreferenceManager.save2Pref(PreferenceManager.prefUserId, null);
    PreferenceManager.save2Pref(PreferenceManager.prefUserToken, null);
    PreferenceManager.save2Pref(PreferenceManager.prefIsRememberMe, false);
  }
}
