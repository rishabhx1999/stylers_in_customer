import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';

class CommonDialog {
  static show(
      {required BuildContext context,
      required String middleText,
      required Function onCancelPress,
      Function? onConfirmPress,
      String? title,
      String? confirmText,
      String? cancelText}) {
    Get.defaultDialog(
      radius: 7.0,
      titlePadding: const EdgeInsets.only(top: 20.0),
      contentPadding: const EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 16.0),
      barrierDismissible: true,
      title: title ?? 'notice'.tr,
      titleStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontSize: AppConsts.commonFontSizeFactor * 16,
          fontWeight: FontWeight.w500,
          color: AppColors.kPrimaryColor),
      middleText: middleText,
      middleTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: AppConsts.commonFontSizeFactor * 12, color: Colors.black),
      confirm: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () {
          onConfirmPress != null ? onConfirmPress() : Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
          child: Text(
            confirmText ?? 'cancel'.tr,
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
          onCancelPress();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
          child: Text(
            cancelText ?? 'ok'.tr,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontSize: AppConsts.commonFontSizeFactor * 12,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
