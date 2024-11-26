import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../consts/app_consts.dart';
import '../../../consts/app_icons.dart';
import '../../../controller/forgot_password/forgot_password_controller.dart';
import '../../../utils/validations.dart';
import '../../widgets/common/common_button.dart';
import '../../widgets/common/common_input_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final _forgotPasswordController = Get.put(ForgotPasswordController());

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
        key: _forgotPasswordController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
              child: Text(
                'enter_your_email_address'.tr,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: AppColors.textColorPrimary,
                    fontSize: AppConsts.commonFontSizeFactor * 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
              child: Text(
                'forgot_password_subtitle'.tr,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: AppConsts.commonFontSizeFactor * 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32),
              child: Text(
                'Email',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.black,
                    fontSize: AppConsts.commonFontSizeFactor * 12),
              ),
            ),
            CommonInputField(
              controller: _forgotPasswordController.emailController,
              hint: '',
              inputType: TextInputType.emailAddress,
              validator: Validations.checkEmailValidations,
            ),
            const Expanded(
                child: SizedBox(
              height: 32,
            )),
            Obx(() => _forgotPasswordController.isLoading.value
                ? Center(
                    child: Container(
                        height: 51,
                        width: 51,
                        padding: const EdgeInsets.all(8),
                        child: const CircularProgressIndicator()))
                : CommonButton(
                    text: 'Proceed',
                    onClick: () {
                      _forgotPasswordController.validateData();
                    })),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
