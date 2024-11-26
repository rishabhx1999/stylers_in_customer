import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import 'package:stylers_in_customer/controller/home/home_controller.dart';
import 'package:stylers_in_customer/views/pages/dashboard/components/drawer_menu_list_title.dart';

import '../../../../utils/preference_manager.dart';
import '../../../dialogs/common/common_dialog.dart';
import '../../../widgets/common/common_button.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);
  final _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 24.0),
          Obx(
            () => Visibility(
              visible: _homeController.isLoggedIn.value,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          const AssetImage(AppImages.imgUserPlaceholder),
                      foregroundImage:
                          NetworkImage(_homeController.personImage.value),
                      radius: 18,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      _homeController.personName.value,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontSize: AppConsts.commonFontSizeFactor * 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.routeEditProfile);
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 18,
                          color: AppColors.kPrimaryColor,
                        ))
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: _homeController.isLoggedIn.value,
              child: const Divider(
                height: 35,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                DrawerMenuListTile(
                  leading: SvgPicture.asset(
                    AppIcons.ic_user_drawer,
                    width: 14,
                  ),
                  title: Text(
                    'profile'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black,
                        fontSize: AppConsts.commonFontSizeFactor * 16),
                  ),
                  onClick: () {
                    if (_homeController.isLoggedIn.value) {
                      Get.toNamed(AppRoutes.routeCustomerProfile);
                    } else {
                      Get.back();
                      CommonDialog.show(
                          context: context,
                          middleText: 'login_required_message'.tr,
                          onCancelPress: () {
                            Get.offAllNamed(AppRoutes.routeLogin);
                            PreferenceManager.save2Pref(
                                PreferenceManager.prefIsVisitor, false);
                          });
                    }
                  },
                ),
                DrawerMenuListTile(
                  leading: Column(
                    children: [
                      SvgPicture.asset(
                        AppIcons.ic_wallet_drawer,
                        width: 14,
                      ),
                    ],
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'wallet'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: Colors.black,
                                fontSize: AppConsts.commonFontSizeFactor * 16),
                      ),
                      Obx(
                        () => Visibility(
                          visible: _homeController.isLoggedIn.value,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'amount_colon'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        color: Colors.black,
                                        fontSize:
                                            AppConsts.commonFontSizeFactor *
                                                12)),
                            const WidgetSpan(
                                child: SizedBox(
                              width: 4,
                            )),
                            TextSpan(
                              text:
                                  '${_homeController.isLoggedIn.value ? _homeController.walletBalance.value : 0} USD',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                            )
                          ])),
                        ),
                      ),
                    ],
                  ),
                  onClick: () {
                    if (_homeController.isLoggedIn.value) {
                      Get.toNamed(AppRoutes.routeCustomerWallet);
                    } else {
                      Get.back();
                      CommonDialog.show(
                          context: context,
                          middleText: 'login_required_message'.tr,
                          onCancelPress: () {
                            Get.offAllNamed(AppRoutes.routeLogin);
                            PreferenceManager.save2Pref(
                                PreferenceManager.prefIsVisitor, false);
                          });
                    }
                  },
                ),
                DrawerMenuListTile(
                  leading: SvgPicture.asset(
                    AppIcons.ic_checklist_drawer,
                    width: 14,
                  ),
                  title: Text(
                    'booking_history'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black,
                        fontSize: AppConsts.commonFontSizeFactor * 16),
                  ),
                  onClick: () {
                    if (_homeController.isLoggedIn.value) {
                      Get.toNamed(AppRoutes.routeBookingHistory);
                    } else {
                      Get.back();
                      CommonDialog.show(
                          context: context,
                          middleText: 'login_required_message'.tr,
                          onCancelPress: () {
                            Get.offAllNamed(AppRoutes.routeLogin);
                            PreferenceManager.save2Pref(
                                PreferenceManager.prefIsVisitor, false);
                          });
                    }
                  },
                ),
                DrawerMenuListTile(
                  leading: SvgPicture.asset(
                    AppIcons.ic_settings_drawer,
                    width: 14,
                  ),
                  title: Text(
                    'settings'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black,
                        fontSize: AppConsts.commonFontSizeFactor * 16),
                  ),
                  onClick: () {
                    Get.toNamed(AppRoutes.routeSettings);
                  },
                ),
                DrawerMenuListTile(
                  leading: SvgPicture.asset(
                    AppIcons.ic_check_round_drawer,
                    width: 14,
                  ),
                  title: Text(
                    'turn_pro'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black,
                        fontSize: AppConsts.commonFontSizeFactor * 16),
                  ),
                  onClick: () {},
                ),
              ],
            ),
          ),
          Obx(
            () => Visibility(
              visible: _homeController.isLoggedIn.value,
              child: Padding(
                padding: const EdgeInsets.only(right: 100.0),
                child: CommonButton(
                  text: 'logout'.tr,
                  onClick: () {
                    Get.back();
                    CommonDialog.show(
                        context: context,
                        middleText: 'message_logout'.tr,
                        cancelText: 'logout'.tr,
                        onCancelPress: () {
                          _homeController.logOut();
                        });
                    // Get.offAllNamed(AppRoutes.routeLogin);
                  },
                  borderRadius: 12,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}
