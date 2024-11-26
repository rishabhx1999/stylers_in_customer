import 'package:get/get.dart';

import '../../model/customer_profile/customer_profile_detail_res_model.dart';
import '../../network/get_requests.dart';

class CustomerProfileController extends GetxController {
  RxBool isLoading = false.obs;

  int? mCustomerId;
  CustomerProfileDetail? profileDetail;
  RxString mCustomerProfileImage = ''.obs;
  RxString mCustomerName = ''.obs;
  RxString mCustomerUsername = ''.obs;
  RxString mCustomerDescription = 'no_description'.tr.obs;
  RxInt mCustomerFollowersCount = 0.obs;
  RxList<dynamic> mCustomerFollowers = <dynamic>[].obs;

  @override
  void onInit() {
    getProfileDetails();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getProfileDetails() async {
    isLoading.value = true;
    var response = await GetRequests.getCustomerProfileDetails();
    isLoading.value = false;
    if (response != null) {
      if (response.success) {
        profileDetail = response.data;
        setProfileData();
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error');
    }
  }

  void setProfileData() {
    if (profileDetail != null) {
      if (profileDetail!.user != null) {
        mCustomerProfileImage.value = profileDetail!.user!.avatar ?? '';
        mCustomerName.value = profileDetail!.user!.name ?? '';
        mCustomerUsername.value = profileDetail!.user!.userName ?? '';
        mCustomerDescription.value =
            profileDetail!.user!.aboutUs ?? 'no_description'.tr;
      }
      if (profileDetail!.followersCount != null) {
        mCustomerFollowersCount.value =
            profileDetail!.followersCount!.totalFollwers ?? 0;
      }
      mCustomerFollowers.value = profileDetail!.followers ?? [];
    }
  }
}
