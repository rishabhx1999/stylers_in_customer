import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/model/details/profile_detail_res_model.dart';
import '../../consts/app_consts.dart';
import '../../network/get_requests.dart';
import '../../network/post_requests.dart';
import '../../utils/helpers.dart';
import '../../utils/preference_manager.dart';

class ProfileDetailController extends GetxController {
  int? customerId;

  int? mProviderId;
  String mProviderRole = '';
  RxString mProviderProfileImage = ''.obs;
  RxString mProviderName = ''.obs;
  RxString mProviderUsername = ''.obs;
  RxBool mIsProviderVerified = false.obs;
  RxString mProviderDescription = 'no_description'.tr.obs;
  RxDouble mProviderAverageRating = 0.0.obs;
  RxInt mProviderRatingCount = 0.obs;
  RxInt mProviderFollowersCount = 0.obs;
  RxDouble mProviderRating = 0.0.obs;
  RxBool mIsFollowing = false.obs;
  RxList<Follower> mProviderFollowers = <Follower>[].obs;
  RxList<Service> mProviderServices = <Service>[].obs;

  RxBool isLoading = false.obs;
  RxBool isProfileLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    getPrefData();
    getArgumentsData();
  }

  void getPrefData() {
    customerId =
        (PreferenceManager.getPref(PreferenceManager.prefUserId) as int?) ?? 0;
  }

  void getArgumentsData() {
    Map? data = Get.arguments;
    if (data != null && data.containsKey(AppConsts.keyProviderId)) {
      mProviderId = data[AppConsts.keyProviderId];
    }
    if (mProviderId != null) {
      fetchStylistProfileDetails();
    }
  }

  void fetchStylistProfileDetails() async {
    isProfileLoading.value = true;
    var response = await GetRequests.getProfileDetail(mProviderId!);
    isProfileLoading.value = false;
    if (response != null) {
      if (response.success) {
        setProfileData(response.profileDetailData!);
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error');
    }
  }

  void setProfileData(ProfileDetailData profileDetailData) {
    mProviderRole = profileDetailData.user!.role ?? '';
    mProviderProfileImage.value = profileDetailData.user?.avatar ?? '';
    mProviderName.value = profileDetailData.user?.name ?? '';
    mProviderUsername.value = profileDetailData.user!.userName ?? '';
    mProviderAverageRating.value = (profileDetailData.rating ?? 0.0).toDouble();
    mProviderFollowersCount.value =
        profileDetailData.followersCount!.totalFollwers ?? 0;
    mProviderRating.value = profileDetailData.rating != null
        ? profileDetailData.rating!.toDouble()
        : 0.0;
    mProviderFollowers.value = profileDetailData.followers ?? <Follower>[];
    mProviderFollowers.refresh();
    mProviderServices.value = profileDetailData.services ?? <Service>[];
    mProviderDescription.value =
        profileDetailData.user?.aboutUs ?? 'no_description'.tr;
    mIsFollowing.value = profileDetailData.isFollow == 1;
  }

  void toggleFollow() async {
    if (customerId != 0) {
      Map<String, dynamic> requestData = {'follower': mProviderId};
      Helpers.printLog(
          screenName: "Follow_request", message: json.encode(requestData));
      isLoading.value = true;
      var result = await PostRequests.follow(requestData);
      isLoading.value = false;
      if (result != null) {
        if (result.success) {
          mIsFollowing.value = result.status == 1;
          mIsFollowing.refresh();
          if (result.status == 1) {
            mProviderFollowers.add(result.data!);
            mProviderFollowersCount.value++;
          }
          if (result.status == 0) {
            mProviderFollowers
                .removeWhere((element) => element.userId == customerId);
            mProviderFollowersCount.value--;
          }
          debugPrint('CUSTOMER_ID = $customerId ');
          for (var element in mProviderFollowers) {
            debugPrint(
                'FOLLOWER_ID = ${element.id}, FOLLOWER_NAME = ${element.user!.name}');
          }
          mProviderFollowers.refresh();
          mProviderFollowersCount.refresh();
        } else {
          Get.snackbar('error'.tr, result.message);
        }
      } else {
        Get.snackbar('error'.tr, 'message_server_error'.tr);
      }
    }
  }
}
