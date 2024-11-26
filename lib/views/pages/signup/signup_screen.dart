import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_formatters.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/controller/signup/signup_controller.dart';
import 'package:stylers_in_customer/utils/validations.dart';

import '../../widgets/common/common_button.dart';
import '../../widgets/common/common_input_field.dart';
import '../../widgets/common/common_password_input_field.dart';
import '../../widgets/common/common_phone_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final _signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarColor: AppColors.appBackgroundColor));

    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: AppColors.appBackgroundColor),
        leading: IconButton(
            onPressed: () {
              _signupController.isFromOnboard.value
                  ? Get.offAllNamed(AppRoutes.routeLogin)
                  : Get.back();
            },
            icon: SvgPicture.asset(AppIcons.ic_back)),
      ),
      body: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
        child: Form(
          key: _signupController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Text(
                  'enter_your_details'.tr,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 22,
                      color: AppColors.textColorPrimary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 8, bottom: 16),
                child: Text(
                  'signup_subtitle'.tr,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 14,
                      color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CommonInputField(
                      controller: _signupController.firstNameController,
                      hint: 'first_name',
                      marginLeft: 16,
                      marginRight: 4,
                      inputType: TextInputType.name,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(
                            AppFormatters.validNameExp)
                      ],
                      validator: Validations.checkFirstNameValidations,
                    ),
                  ),
                  Expanded(
                    child: CommonInputField(
                      controller: _signupController.lastNameController,
                      hint: 'last_name',
                      marginLeft: 4,
                      marginRight: 16,
                      inputType: TextInputType.name,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(
                            AppFormatters.validNameExp)
                      ],
                      validator: Validations.checkLastNameValidations,
                    ),
                  )
                ],
              ),
              CommonInputField(
                controller: _signupController.userNameController,
                hint: 'username',
                inputType: TextInputType.name,
                validator: Validations.checkUsernameValidations,
                inputFormatter: [
                  FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                ],
              ),
              Obx(
                () => Visibility(
                  visible: _signupController.isShowUsernameExistTip.value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      _signupController.isUsernameExist.value
                          ? 'username_already_exist'.tr
                          : '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.red,
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              CommonInputField(
                controller: _signupController.emailController,
                hint: 'enter_your_email',
                inputType: TextInputType.emailAddress,
                validator: Validations.checkEmailValidations,
              ),
              Obx(
                () => Visibility(
                  visible: _signupController.isShowEmailExistTip.value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      _signupController.isEmailExist.value
                          ? 'email_already_exist'.tr
                          : '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.red,
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              CommonPhoneInputField(
                controller: _signupController.phoneController,
                hint: 'your_phone_number',
                inputType: TextInputType.phone,
                selectedCountry: _signupController.selectedCountry,
                validator: Validations.checkPhoneValidations,
                countryCodePickerCallback: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  _signupController.pickCountryCode(context);
                },
              ),
              Obx(
                () => Visibility(
                  visible: _signupController.isShowPhoneExistTip.value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      _signupController.isPhoneExist.value
                          ? 'phone_already_exist'.tr
                          : '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.red,
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              CommonPasswordInputField(
                isShowSuffix: true,
                controller: _signupController.passwordController,
                hint: 'enter_password',
                inputType: TextInputType.visiblePassword,
                validator: Validations.checkPasswordValidations,
              ),
              CommonPasswordInputField(
                  isShowSuffix: true,
                  controller: _signupController.confirmPasswordController,
                  hint: 'repeat_password',
                  inputType: TextInputType.visiblePassword,
                  isShowHelperText: false,
                  validator: (value) {
                    return Validations.checkConfirmPasswordValidations(
                        value, _signupController.passwordController.text);
                  }),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.only(left: 13.0, right: 16.0),
                height: 30,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              _signupController.isAgreeToTerms.value =
                                  !_signupController.isAgreeToTerms.value;
                            },
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            icon: (_signupController.isAgreeToTerms.value
                                ? SvgPicture.asset(AppIcons.ic_check_on)
                                : SvgPicture.asset(AppIcons.ic_check_off)),
                          ),
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'i_agree_to_your'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize:
                                          AppConsts.commonFontSizeFactor * 12,
                                      color: Colors.black.withOpacity(0.4)),
                            ),
                            const WidgetSpan(
                                child: SizedBox(
                              width: 4,
                            )),
                            TextSpan(
                                text: 'terms_and_policies'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            AppConsts.commonFontSizeFactor * 12,
                                        color: AppColors.kPrimaryColor,
                                        decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {})
                          ]),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(() => _signupController.isLoading.value
                  ? const Center(
                      child: SizedBox(
                          height: 51,
                          width: 51,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )))
                  : CommonButton(
                      borderRadius: 2.0,
                      text: 'create_my_account',
                      isEnable: _signupController.isAgreeToTerms,
                      onClick: () {
                        _signupController.validatePageData();
                      })),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
