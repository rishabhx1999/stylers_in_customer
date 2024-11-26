import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/size_config.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import 'package:stylers_in_customer/controller/signup/verify_otp_controller.dart';
import 'package:otp_text_field/style.dart';

import '../../widgets/common/common_app_bar.dart';
import '../../widgets/common/common_button.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({Key? key}) : super(key: key);
  final _verifyOtpController = Get.put(VerifyOtpController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));

    return Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: CommonAppBar(
            title: '',
            onBackTap: () {
              Get.back();
            }),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 32.0,
                  right: 16,
                ),
                child: Image.asset(
                  AppImages.img_verify_otp,
                  height: 130,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 32),
                child: Text(
                  'enter_verification_code'.tr,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textColorPrimary,
                      fontSize: AppConsts.commonFontSizeFactor * 22),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                  child: Obx(
                    () => RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'code_has_been_sent_to'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 14),
                          ),
                          const WidgetSpan(
                              child: SizedBox(
                            width: 8,
                          )),
                          TextSpan(
                              text: _verifyOtpController.registeredEmail.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize:
                                          AppConsts.commonFontSizeFactor * 14))
                        ],
                      ),
                    ),
                  )
                  // Text(
                  //   'otp_subtitle'.tr,
                  //   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  //       color: Colors.black.withOpacity(0.6),
                  //       fontSize: AppConsts.commonFontSizeFactor * 14),
                  // ),
                  ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 40),
                child: OTPTextField(
                  controller: _verifyOtpController.otpFieldController,
                  length: 4,
                  width: SizeConfig.screenWidth,
                  fieldWidth: 60,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 30,
                      color: AppColors.kPrimaryColor),
                  spaceBetween: 16,
                  otpFieldStyle: OtpFieldStyle(
                    borderColor: AppColors.kPrimaryColor.withOpacity(0.2),
                    focusBorderColor: AppColors.kPrimaryColor,
                    disabledBorderColor:
                        AppColors.kPrimaryColor.withOpacity(0.2),
                    enabledBorderColor:
                        AppColors.kPrimaryColor.withOpacity(0.2),
                    errorBorderColor: AppColors.kPrimaryColor.withOpacity(0.2),
                  ),
                  isDense: true,
                  textFieldAlignment: MainAxisAlignment.start,
                  fieldStyle: FieldStyle.underline,
                  onChanged: (pin) {
                    _verifyOtpController.isEnableButton.value = pin.length >= 4;
                  },
                  onCompleted: (pin) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    print("Completed: " + pin);
                    _verifyOtpController.isEnableButton.value = true;

                    _verifyOtpController.otp = pin;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 24),
                child: Obx(
                  () => RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'did_not_receive_code'.tr,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: AppConsts.commonFontSizeFactor * 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.black.withOpacity(0.7))),
                    const WidgetSpan(
                        child: SizedBox(
                      width: 4,
                    )),
                    TextSpan(
                        text: _verifyOtpController.start.value == 0
                            ? 'resend'.tr
                            : '${'resend_code_in'.tr} ${_verifyOtpController.start.value}s',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: AppConsts.commonFontSizeFactor * 12,
                            color: AppColors.kPrimaryColor,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (_verifyOtpController.start.value == 0) {
                              _verifyOtpController.resendOtp();
                            }
                          }),
                  ])),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: Obx(
                  () => Visibility(
                      visible: (_verifyOtpController
                              .signupController?.isLoading.value) ??
                          RxBool(false).value,
                      child: const SizedBox(
                          height: 51,
                          width: 51,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ))),
                ),
              ),
              Center(
                child: Obx(
                  () => Visibility(
                      visible: (_verifyOtpController.isLoading.value) ??
                          RxBool(false).value,
                      child: const SizedBox(
                          height: 51,
                          width: 51,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ))),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonButton(
                    borderRadius: 2.0,
                    text: 'proceed',
                    onClick: () {
                      _verifyOtpController.registerUser();
                      // Get.toNamed(AppRoutes.routeVerificationSuccess);
                    },
                    isEnable: _verifyOtpController.isEnableButton,
                  ),
                  const SizedBox(
                    height: 24,
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
