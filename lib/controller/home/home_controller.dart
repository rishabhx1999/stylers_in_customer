import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stylers_in_customer/model/home/home_data_res_model.dart';
import 'package:stylers_in_customer/model/login/login_res_model.dart';
import 'package:stylers_in_customer/model/services/services_res_model.dart';
import 'package:stylers_in_customer/utils/helpers.dart';
import 'package:stylers_in_customer/utils/permission_handler.dart';
import '../../network/post_requests.dart';
import '../../utils/preference_manager.dart';

class HomeController extends GetxController {
  RxString personName = "User".obs;
  RxString personImage = "".obs;
  RxDouble walletBalance = 0.0.obs;

  RxBool isLocationProvided = false.obs;
  Rx<LatLng> selectedLocation = const LatLng(0.0, 0.0).obs;
  RxString city = 'City'.obs;

  var services = <Service>[].obs;
  var popularStylists = <User>[].obs;
  var nearbyShops = <User>[].obs;
  var banners = <HomeBanner>[].obs;

  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPrefData();
    getCurrentLocation();
  }

  void logOut() {
    PreferenceManager.save2Pref(PreferenceManager.prefIsLogin, false);
    PreferenceManager.removeBasicData();
    if (PreferenceManager.isUserRemembered() == false) {
      PreferenceManager.removeEmailPassword();
    }
    Get.offAllNamed(AppRoutes.routeLogin);
  }

  void getCurrentLocation() async {
    var isHavingLocationPermission =
        await PermissionHandler.requestLocationPermission();

    if (isHavingLocationPermission) {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      debugPrint(
          'CURRENT_LOCATION:- LATITUDE=${position.latitude}, LONGITUDE=${position.longitude}');
      selectedLocation.value = LatLng(position.latitude, position.longitude);
      city.value =
          await Helpers.getCityName(position.latitude, position.longitude);

      isLocationProvided.value = true;

      getHomeData();
    }
  }

  // Future<bool> checkForLocationPermission() async {
  //   if (await Permission.locationWhenInUse.isGranted) {
  //     return true;
  //   } else {
  //     var isGranted = await Permission.locationWhenInUse.request().isGranted;
  //     if (isGranted) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }

  void getHomeData() async {
    Map<String, dynamic>? requestBody = {};
    if (isLocationProvided.value) {
      requestBody = {
        'longitude': selectedLocation.value.longitude.toString(),
        'latitude': selectedLocation.value.latitude.toString(),
      };
    }

    debugPrint('IS_LOGGED_IN = ${isLoggedIn.value}');

    isLoading.value = true;
    HomeDataResModel? response;
    if (isLoggedIn.value) {
      response = await PostRequests.getHomeData(requestBody: requestBody);
    } else {
      response = await PostRequests.getGuestHomeData(requestBody: requestBody);
    }
    isLoading.value = false;
    if (response != null) {
      if (response.success) {
        if (response.homeData?.banners != null) {
          banners.assignAll(response.homeData!.banners!);
        }

        if (response.homeData?.services != null) {
          services.assignAll(response.homeData!.services!);
        }
        if (response.homeData?.popularStylists != null) {
          popularStylists.assignAll(response.homeData!.popularStylists!);
        }

        if (response.homeData?.shopOpeningsNearYou != null) {
          nearbyShops.assignAll(response.homeData!.shopOpeningsNearYou!);
        }

        if (response.homeData?.user != null) {
          saveUserData(response.homeData!.user!);
        }
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
  }

  void saveUserData(User user) {
    PreferenceManager.save2Pref(
        PreferenceManager.prefUserFirstName, user.firstName);
    PreferenceManager.save2Pref(
        PreferenceManager.prefUserLastName, user.lastName);
    PreferenceManager.save2Pref(PreferenceManager.prefUsername, user.userName);
    PreferenceManager.save2Pref(PreferenceManager.prefUserEmail, user.email);
    PreferenceManager.save2Pref(
        PreferenceManager.prefUserMobile, user.phoneNumber);
    PreferenceManager.save2Pref(PreferenceManager.prefUserId, user.id);
    PreferenceManager.save2Pref(PreferenceManager.prefUserImage, user.avatar);
  }

  void getPrefData() {
    if (PreferenceManager.getPref(PreferenceManager.prefIsLogin) != null) {
      isLoggedIn.value =
          (PreferenceManager.getPref(PreferenceManager.prefIsLogin) as bool?)!;
    }

    if (PreferenceManager.getPref(PreferenceManager.prefUserImage) != null) {
      personImage.value =
          (PreferenceManager.getPref(PreferenceManager.prefUserImage)
              as String?)!;
    }

    if (PreferenceManager.getPref(PreferenceManager.prefUserFirstName) !=
            null &&
        PreferenceManager.getPref(PreferenceManager.prefUserLastName) != null) {
      personName.value =
          '${(PreferenceManager.getPref(PreferenceManager.prefUserFirstName) as String?)!} ${(PreferenceManager.getPref(PreferenceManager.prefUserLastName) as String?)!}';
    }

    getHomeData();
  }
}
