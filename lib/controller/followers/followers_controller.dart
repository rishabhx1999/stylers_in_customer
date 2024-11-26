import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';

import '../../model/followers_list/followers_list_res_model.dart';
import '../../network/get_requests.dart';

class FollowersController extends GetxController {
  var isFromCustomerProfile = false.obs;
  RxBool isLoading = false.obs;

  int? mProviderId;
  RxList<Follower> followers = <Follower>[].obs;

  @override
  void onInit() {
    checkIsFromCustomerDetail();
    super.onInit();
  }

  void checkIsFromCustomerDetail() {
    isFromCustomerProfile.value =
        Get.previousRoute == AppRoutes.routeCustomerProfile;
    if (isFromCustomerProfile.value) {
      getFollowers();
    } else {
      getProviderId();
    }
  }

  void getProviderId() {
    Map data = Get.arguments;
    if (data.containsKey(AppConsts.keyProviderId)) {
      mProviderId = data[AppConsts.keyProviderId];
      if (mProviderId != null) {
        getFollowers();
      }
    }
  }

  void getFollowers() async {
    isLoading.value = true;
    var response;
    if (isFromCustomerProfile.value) {
      response = await GetRequests.getCustomerFollowers();
    } else {
      response = await GetRequests.getProviderFollowers(mProviderId!);
    }
    isLoading.value = false;
    if (response != null) {
      if (response.success) {
        followers.value = response.data!;
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error');
    }
  }

  onTapUnfollow(BuildContext context) {
    Get.defaultDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Adam Sandler',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: AppConsts.commonFontSizeFactor * 16,
                color: AppColors.kPrimaryColor),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            'unfollow_dialog_notice'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: AppConsts.commonFontSizeFactor * 12,
                color: Colors.black,
                fontWeight: FontWeight.w300),
          )
        ],
      ),
      radius: 7.0,
      titlePadding: const EdgeInsets.only(top: 20.0),
      contentPadding: const EdgeInsets.fromLTRB(18.0, 2.0, 18.0, 16.0),
      barrierDismissible: true,
      title: 'unfollow'.tr,
      titleStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: AppConsts.commonFontSizeFactor * 16, color: Colors.black),
      // middleText: 'unfollow_dialog_notice'.tr,
      // middleTextStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
      //     fontSize: AppConsts.commonFontSizeFactor * 12, color: Colors.black),
      confirm: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
          child: Text(
            'cancel'.tr,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.kPrimaryColor,
                  fontSize: AppConsts.commonFontSizeFactor * 12,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
      cancel: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.kPrimaryColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)))),
        onPressed: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
          child: Text(
            'unfollow'.tr,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontSize: AppConsts.commonFontSizeFactor * 12,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
