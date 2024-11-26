import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/controller/settings/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  final _settingsController = Get.put(SettingsController());

  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'settings'.tr,
          style: Theme.of(context).textTheme.headline4?.copyWith(
              color: Colors.black,
              fontSize: AppConsts.commonFontSizeFactor * 16),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AppIcons.ic_back)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 21.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 34.79),
            child: Text(
              'notifications'.tr,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.black,
                  fontSize: AppConsts.commonFontSizeFactor * 14.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 17.85,
          ),
          Divider(
            indent: 24.0,
            endIndent: 29.86,
            height: 0.83,
            thickness: 0.83,
            color: AppColors.color_D7,
          ),
          const SizedBox(
            height: 6.94,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.62, right: 41.47),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'show_notifications'.tr,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 12.0,
                      color: Colors.black),
                ),
                Obx(() => Transform.scale(
                      scale: 0.75,
                      child: CupertinoSwitch(
                          activeColor: AppColors.kPrimaryColor,
                          value: _settingsController.isShowNotifications.value,
                          onChanged: (value) {
                            _settingsController.isShowNotifications.value =
                                value;
                          }),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 6.77,
          ),
          Divider(
            indent: 24.0,
            endIndent: 29.86,
            height: 0.83,
            thickness: 0.83,
            color: AppColors.color_D7,
          ),
          const SizedBox(
            height: 16.77,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.62),
            child: Text(
              'appointment_status_change_notify'.tr,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.black,
                  fontSize: AppConsts.commonFontSizeFactor * 14.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 17.85,
          ),
          Divider(
            indent: 24.0,
            endIndent: 29.86,
            height: 0.83,
            thickness: 0.83,
            color: AppColors.color_D7,
          ),
          const SizedBox(
            height: 6.94,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.62, right: 41.47),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'app_notification'.tr,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 12.0,
                      color: Colors.black),
                ),
                Obx(() => Transform.scale(
                      scale: 0.75,
                      child: CupertinoSwitch(
                          activeColor: AppColors.kPrimaryColor,
                          value: _settingsController.isAppNotifications.value,
                          onChanged: (value) {
                            _settingsController.isAppNotifications.value =
                                value;
                          }),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 6.77,
          ),
          Divider(
            indent: 24.0,
            endIndent: 29.86,
            height: 0.83,
            thickness: 0.83,
            color: AppColors.color_D7,
          ),
          const SizedBox(
            height: 16.77,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.62),
            child: Text(
              'settings'.tr,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.black,
                  fontSize: AppConsts.commonFontSizeFactor * 14.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 17.85,
          ),
          Divider(
            indent: 24.0,
            endIndent: 29.86,
            height: 0.83,
            thickness: 0.83,
            color: AppColors.color_D7,
          ),
          const SizedBox(
            height: 18.18,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.62, right: 58.0),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'address'.tr,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 12.0,
                        color: Colors.black),
                  ),
                  SvgPicture.asset(
                    AppIcons.ic_arrow_forward,
                    height: 12.0,
                    color: AppColors.color_21,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 18.68,
          ),
          Divider(
            indent: 24.0,
            endIndent: 29.86,
            height: 0.83,
            thickness: 0.83,
            color: AppColors.color_D7,
          ),
          const SizedBox(
            height: 12.44,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.62, right: 58.0),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'language'.tr,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 6.64,
                        color: AppColors.color_BB),
                  ),
                  const SizedBox(
                    height: 3.45,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'English (United States)',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontSize: AppConsts.commonFontSizeFactor * 12.0,
                            color: Colors.black),
                      ),
                      SvgPicture.asset(
                        AppIcons.ic_arrow_forward,
                        height: 12.0,
                        color: AppColors.color_21,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12.54,
          ),
          Divider(
            indent: 24.0,
            endIndent: 29.86,
            height: 0.83,
            thickness: 0.83,
            color: AppColors.color_D7,
          ),
          const SizedBox(
            height: 12.44,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.62, right: 58.0),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'country'.tr,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 6.64,
                        color: AppColors.color_BB),
                  ),
                  const SizedBox(
                    height: 3.45,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'United States',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontSize: AppConsts.commonFontSizeFactor * 12.0,
                            color: Colors.black),
                      ),
                      SvgPicture.asset(
                        AppIcons.ic_arrow_forward,
                        height: 12.0,
                        color: AppColors.color_21,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12.54,
          ),
          Divider(
            indent: 24.0,
            endIndent: 29.86,
            height: 0.83,
            thickness: 0.83,
            color: AppColors.color_D7,
          ),
          const SizedBox(
            height: 18.18,
          ),
          GestureDetector(behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.toNamed(AppRoutes.routeChangePassword);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 35.62, right: 58.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'change_password'.tr,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 12.0,
                        color: Colors.black),
                  ),
                  SvgPicture.asset(
                    AppIcons.ic_arrow_forward,
                    height: 12.0,
                    color: AppColors.color_21,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 18.68,
          ),
          Divider(
            indent: 24.0,
            endIndent: 29.86,
            height: 0.83,
            thickness: 0.83,
            color: AppColors.color_D7,
          ),
        ],
      ),
    );
  }
}
