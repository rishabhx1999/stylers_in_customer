import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/model/on_boarding/onboarding_page_model.dart';
import 'package:stylers_in_customer/utils/preference_manager.dart';

class OnBoardingController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  RxInt selectedPage = 0.obs;

  @override
  void onInit() {
    print('onboard init');
    super.onInit();
  }



  nextPage() {
    if (selectedPage.value < 2) {
      selectedPage.value++;
      pageController.animateToPage(selectedPage.value,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    } else {
      PreferenceManager.save2Pref(PreferenceManager.prefIsFirstLaunch, false);
      Get.offAllNamed(AppRoutes.routeSignup,
          arguments: {AppConsts.keySignupFrom: AppRoutes.routeOnBoardingPage});
    }
  }

  previousPage() {
    if (selectedPage > 0) {
      selectedPage.value--;
      pageController.animateToPage(selectedPage.value,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }

  createPages() {}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
