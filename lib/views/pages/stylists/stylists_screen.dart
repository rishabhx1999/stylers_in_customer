import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/controller/stylists/stylists_screen_controller.dart';

import '../../../model/login/login_res_model.dart';
import '../../widgets/common/common_stylist_widget_shimmer.dart';
import '../../widgets/common/stylist_widget_home.dart';

class StylistsScreen extends StatelessWidget {
  StylistsScreen({Key? key}) : super(key: key);

  final _stylistsScreenController = Get.put(StylistsScreenController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        title: Text(
          'stylists'.tr,
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
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          itemBuilder: (context, index) {
            return _stylistsScreenController.isLoading.value
                ? const CommonStylistWidgetShimmer()
                : StylistWidgetHome(
                    user: _stylistsScreenController.stylists[index],
                    onTab: (User user) {
                      Get.toNamed(AppRoutes.routeProfileDetailScreen,arguments: {
                        AppConsts.keyProviderId: user.id,
                      });
                    },
                  );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 8,
            );
          },
          itemCount: _stylistsScreenController.isLoading.value
              ? 10
              : _stylistsScreenController.stylists.length,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
