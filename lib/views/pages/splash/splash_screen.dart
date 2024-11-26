import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/utils/preference_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  _moveToNextScreen() {
    var nextScreen = PreferenceManager.isFirstTimeLaunch()
        ? AppRoutes.routeOnBoardingPage
        : PreferenceManager.isUserLoggedIn() ||
                PreferenceManager.isUserVisitor()
            ? AppRoutes.routeDashboard
            : AppRoutes.routeLogin;
    Get.offNamed(nextScreen);
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      _moveToNextScreen();
    });

    // SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      color: const Color(0xFFFFEDF6),
      child: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 79.0,
          ),
          Image.asset(
            'assets/images/splash.png',
            width: double.infinity,
          ),
          const SizedBox()
        ],
      )),
    );
  }
}
