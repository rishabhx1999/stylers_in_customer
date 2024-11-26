import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_routes.dart';
import '../../network/post_requests.dart';
import '../../utils/helpers.dart';

class SetNewPasswordController extends GetxController {
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  final formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  String email = '';

  @override
  void onInit() {
    super.onInit();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    setupArgumentsData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  validateData() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      setNewPassword();
    }
  }

  setNewPassword() async {
    Map<String, dynamic> requestBody = {
      'email': email,
      'new_password': passwordController.text.toString().trim(),
    };

    isLoading.value = true;
    var response = await PostRequests.changeForgottenPassword(requestBody);
    isLoading.value = false;

    if (response != null) {
      if (response.success) {
        Get.offAllNamed(AppRoutes.routePasswordUpdated);
      } else {
        Get.snackbar('error'.tr, response.message);
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
  }

  void setupArgumentsData() {
    Helpers.printLog(screenName: "SetupArgs", message: "init");
    Map<String, dynamic> data = Get.arguments;
    email = data['email'];
  }
}
