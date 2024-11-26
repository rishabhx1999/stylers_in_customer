import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/controller/followers/followers_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';

import '../../../config/app_colors.dart';
import '../../widgets/common/follower_widget.dart';
import '../../widgets/common/follower_widget_shimmer.dart';

class FollowersScreen extends StatelessWidget {
  final _followersController = Get.put(FollowersController());

  FollowersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Obx(
          () => Text(
            _followersController.isFromCustomerProfile.value
                ? 'my_followers'.tr
                : 'followers'.tr,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.black,
                fontSize: AppConsts.commonFontSizeFactor * 16),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AppIcons.ic_back)),
      ),
      body: Obx(
        () => ListView.separated(
            itemBuilder: (context, index) {
              return Obx(
                () => _followersController.isLoading.value
                    ? const FollowerWidgetShimmer()
                    : FollowerWidget(
                        followerData: _followersController.followers[index],
                      ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 1.0,
                color: Colors.black.withOpacity(0.1),
              );
            },
            itemCount: _followersController.isLoading.value
                ? 5
                : _followersController.followers.length),
      ),
    );
  }
}
