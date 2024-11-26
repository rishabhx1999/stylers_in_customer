import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_images.dart';

import '../../../controller/signup/verfication_sucess_controller.dart';
import '../../widgets/common/common_button.dart';

class VerificationSuccessScreen extends StatelessWidget {
  VerificationSuccessScreen({Key? key}) : super(key: key);
  final _verificationSuccessController =
      Get.put(VerificationSuccessController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      // appBar: AppBar(automaticallyImplyLeading: false,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 48.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16,
            ),
            child: Image.asset(
              AppImages.img_user_check,
              height: 82.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
            child: Text(
              'congratulations'.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textColorPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: AppConsts.commonFontSizeFactor * 22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
            child: Text(
              'your_account_has_been_created'.tr,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: AppConsts.commonFontSizeFactor * 14),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'welcome_to'.tr,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 26,
                      color: AppColors.textColorPrimary)),
              const WidgetSpan(
                  child: SizedBox(
                width: 6,
              )),
              TextSpan(
                  text: 'stylersin'.tr,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 26,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kPrimaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {})
            ])),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16,
            ),
            child: Obx(
              () => Text(
                _verificationSuccessController.name.value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textColorPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: AppConsts.commonFontSizeFactor * 32),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Center(child: SvgPicture.asset(AppImages.img_welcome)),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonButton(
                  text: 'proceed',
                  onClick: () {
                    Get.offAllNamed(AppRoutes.routeDashboard);
                  }),
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
