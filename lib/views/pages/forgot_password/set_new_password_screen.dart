import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../consts/app_consts.dart';
import '../../../consts/app_icons.dart';
import '../../../controller/forgot_password/set_new_password_controller.dart';
import '../../../utils/validations.dart';
import '../../widgets/common/common_button.dart';
import '../../widgets/common/common_password_input_field.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({Key? key}) : super(key: key);

  final _setNewPasswordController = Get.put(SetNewPasswordController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AppIcons.ic_back)),
      ),
      body: Form(
        key: _setNewPasswordController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
              child: Text(
                'new_password'.tr,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textColorPrimary,
                    fontSize: AppConsts.commonFontSizeFactor * 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
              child: Text(
                'set_new_password_subtitle'.tr,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: AppConsts.commonFontSizeFactor * 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32),
              child: Text(
                'new_password'.tr,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.black,
                    fontSize: AppConsts.commonFontSizeFactor * 12),
              ),
            ),
            CommonPasswordInputField(
              controller: _setNewPasswordController.passwordController,
              hint: 'enter_password',
              inputType: TextInputType.visiblePassword,
              validator: Validations.checkPasswordValidations,
              isShowSuffix: true,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
              child: Text(
                'enter_password_again'.tr,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.black,
                      fontSize: AppConsts.commonFontSizeFactor * 12,
                    ),
              ),
            ),
            CommonPasswordInputField(
              controller: _setNewPasswordController.confirmPasswordController,
              hint: 'repeat_password',
              inputType: TextInputType.visiblePassword,
              validator: (value) {
                return Validations.checkConfirmPasswordValidations(
                    value, _setNewPasswordController.passwordController.text);
              },
              isShowHelperText: false,
              isShowSuffix: true,
            ),
            // Expanded(
            //     child: Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Obx(
            //       () => _setNewPasswordController.isLoading.value
            //           ? Center(
            //               child: Container(
            //                   height: 51,
            //                   width: 51,
            //                   padding: const EdgeInsets.all(8),
            //                   child: const CircularProgressIndicator()))
            //           : CommonButton(
            //               text: 'Next',
            //               onClick: () {
            //                 FocusManager.instance.primaryFocus?.unfocus();
            //                 _setNewPasswordController.validateData();
            //               }),
            //     ),
            //     const SizedBox(
            //       height: 24,
            //     )
            //   ],
            // )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 16),
        child: Obx(
          () => _setNewPasswordController.isLoading.value
              ? Center(
                  child: Container(
                      height: 51,
                      width: 51,
                      padding: const EdgeInsets.all(8),
                      child: const CircularProgressIndicator()))
              : CommonButton(
                  text: 'Next',
                  onClick: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _setNewPasswordController.validateData();
                  }),
        ),
      ),
    );
  }
}
