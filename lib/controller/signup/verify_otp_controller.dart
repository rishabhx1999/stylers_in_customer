import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import '../../network/post_requests.dart';
import '../../utils/helpers.dart';
import 'signup_controller.dart';

const int timerCount = 59;

class VerifyOtpController extends GetxController {
  final OtpFieldController otpFieldController = OtpFieldController();

  SignupController? signupController;

  RxBool isEnableButton = false.obs;
  RxBool isLoading = false.obs;

  RxString registeredEmail = ''.obs;
  int? mOtp;
  String otp = '';
  Timer? _timer;
  final RxInt start = timerCount.obs;

  @override
  void onInit() {
    super.onInit();

    setupArgumentsData();
    startTimer();
    signupController = Get.find<SignupController>();
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

  void setupArgumentsData() {
    Helpers.printLog(screenName: "SetupArgs", message: "init");
    Map<String, dynamic> data = Get.arguments;

    registeredEmail.value = data['email'];
    mOtp = data['otp'];
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

  void resendOtp() async {
    otpFieldController.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    if (registeredEmail.value.isEmpty) return;
    isLoading.value = true;
    var response = await PostRequests.requestOtp(registeredEmail.value);
    isLoading.value = false;
    if (response != null) {
      mOtp = response.data;
      start.value = timerCount;
      startTimer();
    } else {
      Get.snackbar('error'.tr, response!.message);
    }
  }

  void registerUser() {
    print('typed otp: $otp, otp: $mOtp');

    if (mOtp.toString() == otp) {
      signupController!.registerUser();
    } else {
      Get.snackbar('error'.tr, 'wrong_otp_entered'.tr);
    }
  }
}
