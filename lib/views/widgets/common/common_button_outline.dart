import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../consts/app_consts.dart';

class CommonButtonOutline extends StatelessWidget {
  String text;
  Color? borderColor;
  Color? textColor;
  VoidCallback clickAction;
  RxBool? isEnable = false.obs;
  double? borderRadius;
  double? elevation;
  double? width;
  double? height;
  Color? backgroundColor;
  double? borderWidth;
  double? horizontalMargin;

  CommonButtonOutline(
      {Key? key,
      required this.text,
      this.textColor,
      this.borderColor,
      required this.clickAction,
      this.isEnable,
      this.borderRadius,
      this.elevation,
      this.width,
      this.height,
      this.backgroundColor,
      this.borderWidth,
      this.horizontalMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 51,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin ?? 16.0,
      ),
      width: width ?? double.infinity,
      decoration: const BoxDecoration(),
      child: Obx(
        () => ElevatedButton(
          onPressed: isEnable?.value ?? RxBool(true).value ? clickAction : null,
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(backgroundColor ?? Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
                side: BorderSide(
                    width: borderWidth ?? 1.0,
                    color: borderColor ?? AppColors.kPrimaryColor),
              )),
              elevation: MaterialStateProperty.all(elevation ?? 2.0)),
          child: Center(
            child: Text(
              text.tr,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor ?? AppColors.kPrimaryColor,
                    fontSize: AppConsts.commonFontSizeFactor * 13,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
