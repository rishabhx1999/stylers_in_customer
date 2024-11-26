import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../config/app_colors.dart';
import '../../../config/size_config.dart';
import '../../../consts/app_consts.dart';
import '../../../consts/app_icons.dart';
import '../../../consts/app_images.dart';
import '../../../controller/forgot_password/forgot_password_verify_otp_controller.dart';
import '../../widgets/common/common_button.dart';

class VerifyOtpForgotPassword extends StatelessWidget {
  VerifyOtpForgotPassword({Key? key}) : super(key: key);
  final _forgotPasswordVerifyOtpController =
      Get.put(ForgotPasswordVerifyOtpController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    _forgotPasswordVerifyOtpController.setupArgumentsData();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AppIcons.ic_back)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
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
              'enter_otp'.tr,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textColorPrimary,
                  fontSize: AppConsts.commonFontSizeFactor * 22),
            ),
          ),
          Obx(() => Visibility(
                visible:
                    !_forgotPasswordVerifyOtpController.isLoadingOtp.value &&
                        _forgotPasswordVerifyOtpController.serverOtp.value
                                .toString()
                                .trim() !=
                            '0' &&
                        _forgotPasswordVerifyOtpController.serverOtp.value
                                .toString()
                                .trim() !=
                            '',
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                  child: Text(
                    '${'code_has_been_sent_to'.tr} ${_forgotPasswordVerifyOtpController.registeredEmail.value}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: AppConsts.commonFontSizeFactor * 14),
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 40),
            child: OTPTextField(
              controller: _forgotPasswordVerifyOtpController.otpFieldController,
              length: 4,
              width: SizeConfig.screenWidth,
              fieldWidth: 60,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: AppConsts.commonFontSizeFactor * 30,
                  color: AppColors.kPrimaryColor),
              spaceBetween: 16,
              otpFieldStyle: OtpFieldStyle(
                borderColor: AppColors.kPrimaryColor,
                focusBorderColor: AppColors.kPrimaryColor,
                disabledBorderColor: AppColors.kPrimaryColor,
                enabledBorderColor: AppColors.kPrimaryColor,
                errorBorderColor: AppColors.kPrimaryColor,
              ),
              isDense: true,
              textFieldAlignment: MainAxisAlignment.start,
              fieldStyle: FieldStyle.underline,
              onChanged: (pin) {
                _forgotPasswordVerifyOtpController.isEnableButton.value =
                    pin.length >= 4;
              },
              onCompleted: (pin) {
                FocusManager.instance.primaryFocus?.unfocus();
                print("Completed: " + pin);
                _forgotPasswordVerifyOtpController.typedOtp.value =
                    int.parse(pin.trim());
                _forgotPasswordVerifyOtpController.isEnableButton.value = true;
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24),
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
                    width: 0,
                  )),
                  TextSpan(
                      text: _forgotPasswordVerifyOtpController.start.value == 0
                          ? 'resend'.tr
                          : '${'resend_code_in'.tr} ${_forgotPasswordVerifyOtpController.start.value}s',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          color: AppColors.kPrimaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (_forgotPasswordVerifyOtpController.start.value ==
                              0) {
                            _forgotPasswordVerifyOtpController.resendOtp();
                          }
                        })
                ])),
              )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonButton(
                text: 'proceed',
                onClick: () {
                  _forgotPasswordVerifyOtpController.verifyOtp();
                },
                isEnable: _forgotPasswordVerifyOtpController.isEnableButton,
              ),
              const SizedBox(
                height: 24,
              )
            ],
          ))
        ],
      ),
    );
  }
}
