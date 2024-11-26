import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/utils/validations.dart';
import 'package:stylers_in_customer/controller/change_password/change_password_controller.dart';

import '../../../config/app_colors.dart';
import '../../widgets/common/common_button.dart';
import '../../widgets/common/common_password_input_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _changePasswordController = Get.put(ChangePasswordController());

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text(
          'change_password_title'.tr,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.black,
              fontSize: AppConsts.commonFontSizeFactor * 16),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AppIcons.ic_back)),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: _changePasswordController.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 22.0,
                  ),
                  Text(
                    'update_password'.tr,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.black,
                        fontSize: AppConsts.commonFontSizeFactor * 16),
                  ),
                  const SizedBox(
                    height: 9.0,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black.withOpacity(0.6),
                        ),
                  ),
                  const SizedBox(
                    height: 36.0,
                  ),
                  Text(
                    'enter_current_password'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black,
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  CommonPasswordInputField(
                    isShowHelperText: false,
                    controller:
                        _changePasswordController.currentPasswordController,
                    isShowSuffix: true,
                    hint: '',
                    horizontalMargin: 0,
                    verticalMargin: 0,
                    inputType: TextInputType.visiblePassword,
                    validator: Validations.checkPasswordValidations,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'new_password'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black,
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  CommonPasswordInputField(
                    isShowHelperText: false,
                    controller: _changePasswordController.newPasswordController,
                    isShowSuffix: true,
                    hint: '',
                    horizontalMargin: 0,
                    verticalMargin: 0,
                    inputType: TextInputType.visiblePassword,
                    validator: Validations.checkPasswordValidations,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'enter_password_again'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black,
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  CommonPasswordInputField(
                    isShowHelperText: false,
                    controller:
                        _changePasswordController.againNewPasswordController,
                    isShowSuffix: true,
                    hint: '',
                    horizontalMargin: 0,
                    verticalMargin: 0,
                    inputType: TextInputType.visiblePassword,
                    validator: (value) {
                      return Validations.checkConfirmPasswordValidations(value,
                          _changePasswordController.newPasswordController.text);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: 84.0,
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 33.0),
          child: Obx(
            () => _changePasswordController.isLoading.value
                ? const Center(
                    child: SizedBox(
                        height: 51,
                        width: 51,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )))
                : CommonButton(
                    text: 'save_changes'.tr,
                    borderRadius: 2.0,
                    onClick: () {
                      _changePasswordController.validatePageData();
                    },
                    horizontalMargin: 0,
                  ),
          )),
    );
  }
}
