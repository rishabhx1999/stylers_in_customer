import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import 'package:stylers_in_customer/controller/login/login_controller.dart';
import 'package:stylers_in_customer/utils/validations.dart';

import '../../../utils/preference_manager.dart';
import '../../widgets/common/common_button.dart';
import '../../widgets/common/common_input_field.dart';
import '../../widgets/common/common_password_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarColor: AppColors.appBackgroundColor));

    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Form(
              key: _loginController.formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 26.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 19.0),
                      child: Image.asset(
                        AppImages.img_login,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 0),
                      child: Text(
                        'welcome_back'.tr,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.textColorPrimary,
                            fontSize: AppConsts.commonFontSizeFactor * 22),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 9),
                      child: Text(
                        'login_sub_title'.tr,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: AppConsts.commonFontSizeFactor * 13),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CommonInputField(
                      controller: _loginController.emailController,
                      hint: 'enter_your_email',
                      onChanged: (value) {},
                      validator: Validations.checkEmailValidations,
                    ),
                    CommonPasswordInputField(
                      isShowSuffix: true,
                      controller: _loginController.passwordController,
                      hint: 'enter_your_password',
                      validator: Validations.checkPasswordEmptyValidations,
                      isShowHelperText: false,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      height: 30,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => TextButton.icon(
                                onPressed: () {
                                  _loginController.isRememberMe.value =
                                      !_loginController.isRememberMe.value;
                                },
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                icon: (_loginController.isRememberMe.value
                                    ? SvgPicture.asset(AppIcons.ic_check_on)
                                    : SvgPicture.asset(AppIcons.ic_check_off)),
                                label: Text(
                                  'remember_me'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize:
                                              AppConsts.commonFontSizeFactor *
                                                  12,
                                          color: Colors.black),
                                )),
                          ),
                          TextButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Get.toNamed(AppRoutes.routeForgotPassword);
                              },
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      AppColors.kPrimaryColor
                                          .withOpacity(0.02))),
                              child: Text(
                                'forgot_password_que'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontSize:
                                            AppConsts.commonFontSizeFactor * 12,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.kPrimaryDarkColor,
                                        decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Obx(() => _loginController.isLoading.value
                        ? Center(
                            child: Container(
                                height: 51,
                                width: 51,
                                padding: const EdgeInsets.all(8),
                                child: const CircularProgressIndicator()))
                        : CommonButton(
                            text: 'sign_in'.tr,
                            onClick: () {
                              _loginController.signIn();
                            })),
                    const SizedBox(
                      height: 8,
                    ),
                    Stack(
                      children: [
                        Divider(
                          color: AppColors.kPrimaryDarkColor.withOpacity(0.63),
                          indent: 100,
                          endIndent: 100,
                        ),
                        Center(
                          child: Container(
                            color: AppColors.appBackgroundColor,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'or'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize:
                                          AppConsts.commonFontSizeFactor * 12,
                                      color: AppColors.kPrimaryDarkColor),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                // _loginController.loginWithFb();
                              },
                              icon: Image.asset(
                                AppIcons.ic_facebook,
                                height: 30.0,
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          IconButton(
                              onPressed: () {
                                _loginController.loginWithGoogle();
                              },
                              icon: Image.asset(
                                AppIcons.ic_google,
                                height: 30,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "dont_have_account".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize:
                                          AppConsts.commonFontSizeFactor * 12)),
                          const WidgetSpan(
                              child: SizedBox(
                            width: 4,
                          )),
                          TextSpan(
                              text: "sign_up".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: AppColors.kPrimaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          AppConsts.commonFontSizeFactor * 12),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Get.toNamed(AppRoutes.routeSignup,
                                      arguments: {
                                        AppConsts.keySignupFrom:
                                            AppRoutes.routeLogin
                                      });
                                })
                        ])),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          PreferenceManager.save2Pref(
                              PreferenceManager.prefIsVisitor, true);
                          Get.offAllNamed(AppRoutes.routeDashboard);
                        },
                        child: Text(
                          'login_as_a_visitor'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kPrimaryColor,
                                  fontSize: AppConsts.commonFontSizeFactor * 12,
                                  decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            ),
          ),
          Obx(() => Visibility(
                visible: _loginController.isSocialLoginLoading.value,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
