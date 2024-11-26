import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stylers_in_customer/config/app_colors.dart';

class CommonButton extends StatelessWidget {
  String text;
  Color? backgroundColor;
  Color? textColor;
  VoidCallback onClick;
  RxBool? isEnable = false.obs;
  double? borderRadius;
  double? horizontalMargin;
  double? height;

  CommonButton({
    Key? key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    required this.onClick,
    this.isEnable,
    this.borderRadius,
    this.horizontalMargin,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 51,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin ?? 16,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Obx(
        () => ElevatedButton(
          onPressed: isEnable?.value ?? RxBool(true).value ? onClick : null,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  isEnable?.value ?? RxBool(true).value
                      ? backgroundColor ?? AppColors.kPrimaryColor
                      : backgroundColor ??
                          AppColors.kPrimaryDarkColor.withOpacity(0.29)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 4)))),
          child: Center(
            child: Text(
              text.tr,
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: textColor ?? Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
