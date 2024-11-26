import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_routes.dart';
import '../../network/post_requests.dart';

class ForgotPasswordController extends GetxController {
  late final TextEditingController emailController;

  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    emailController = TextEditingController();
    super.onInit();
  }

  validateData() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      requestOtp();
    }
  }

  void requestOtp() async {
    Map<String, dynamic> requestBody = {
      'email': emailController.text.toString().trim(),
    };
    isLoading.value = true;
    var response = await PostRequests.forgotPassword(requestBody);
    isLoading.value = false;
    if (response != null) {
      if (response.success) {
        Get.toNamed(AppRoutes.routeVerifyOtpForgotPassword, arguments: {
          'email': emailController.text,
          'otp': response.data,
        });
      } else {
        Get.snackbar('error'.tr, response.message);
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
