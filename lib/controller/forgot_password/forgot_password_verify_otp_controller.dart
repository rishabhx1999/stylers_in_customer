import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../../config/app_routes.dart';
import '../../network/post_requests.dart';
import '../../utils/helpers.dart';

const int timerCount = 59;

class ForgotPasswordVerifyOtpController extends GetxController {
  final OtpFieldController otpFieldController = OtpFieldController();
  Timer? _timer;
  final RxInt start = timerCount.obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingOtp = false.obs;
  RxBool isEnableButton = false.obs;
  RxString registeredEmail = ''.obs;
  RxInt serverOtp = 0.obs;
  RxInt typedOtp = 0.obs;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void resendOtp() async {
    otpFieldController.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    if (registeredEmail.value.isEmpty) return;

    Map<String, dynamic> requestBody = {
      'email': registeredEmail.value,
    };
    isLoadingOtp.value = true;
    var response = await PostRequests.forgotPassword(requestBody);
    isLoadingOtp.value = false;
    if (response != null) {
      if (response.success) {
        debugPrint('OTP = ${response.data!}');
        serverOtp.value = response.data!;
        start.value = timerCount;
        startTimer();
      } else {
        Get.snackbar('error'.tr, response!.message);
      }
    }
  }

  startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (start.value == 0) {
        _timer?.cancel();
      } else {
        start.value--;
      }
    });
  }

  void setupArgumentsData() {
    Helpers.printLog(screenName: "SetupArgs", message: "init");
    Map<String, dynamic> data = Get.arguments;

    registeredEmail.value = data['email'];
    serverOtp.value = data['otp'];
  }

  verifyOtp() {
    debugPrint('OTP = ${serverOtp.value}, Entered OTP = ${typedOtp.value}');
    if (serverOtp.value.toString().trim() == typedOtp.value.toString().trim()) {
      Get.offNamed(AppRoutes.routeSetNewPassword, arguments: {
        'email': registeredEmail.value,
      });
    } else {
      Get.snackbar('error'.tr, 'wrong_otp_entered'.tr);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    otpFieldController.clear();
    _timer?.cancel();
    super.onClose();
  }
}
