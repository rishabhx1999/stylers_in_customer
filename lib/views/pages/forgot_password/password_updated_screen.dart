import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../config/app_routes.dart';
import '../../../consts/app_consts.dart';
import '../../../consts/app_images.dart';
import '../../widgets/common/common_button.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  PasswordUpdatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppImages.img_check_round),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 29.0, right: 29.0, top: 16),
                  child: Text(
                    textAlign: TextAlign.center,
                    'new_password_has_been_created'.tr,
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 22,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 29.0, right: 29.0, top: 8),
                  child: Text(
                    'password_updated_subtitle'.tr,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 12,
                        color: Colors.black.withOpacity(0.4)),
                  ),
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: CommonButton(
                    text: 'proceed'.tr,
                    onClick: () {
                      Get.offNamedUntil(AppRoutes.routeLogin, (route) => true);
                    }),
              ))
        ],
      ),
    );
  }
}
