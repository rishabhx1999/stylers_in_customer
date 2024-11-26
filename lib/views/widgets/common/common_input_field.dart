import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';

class CommonInputField extends StatelessWidget {
  String hint;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController controller;
  TextInputType? inputType;
  double? marginLeft;
  double? marginRight;
  double? marginTop;
  double? marginBottom;
  List<TextInputFormatter>? inputFormatter;
  int? maxLines;
  double? inputHorizontalPadding;
  double? inputVerticalPadding;
  int? errorMaxLines;
  bool? isEnable;
  bool? showFloatingLabel;
  TextCapitalization? textCapitalization;

  var inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.kPrimaryColor.withOpacity(0.28)));

  var errorInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.red.withOpacity(0.28)));

  CommonInputField({
    Key? key,
    required this.controller,
    required this.hint,
    this.onChanged,
    this.validator,
    this.inputType,
    this.inputFormatter,
    this.marginLeft,
    this.marginRight,
    this.marginTop,
    this.marginBottom,
    this.maxLines,
    this.inputHorizontalPadding,
    this.inputVerticalPadding,
    this.errorMaxLines,
    this.isEnable,
    this.showFloatingLabel,
    this.textCapitalization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: marginLeft ?? 16,
          right: marginRight ?? 16,
          top: marginTop ?? 8,
          bottom: marginBottom ?? 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines ?? 1,
        style: Theme.of(context)
            .textTheme
            .headline5
            ?.copyWith(color: Colors.black),
        keyboardType: inputType ?? TextInputType.name,
        cursorColor: AppColors.kPrimaryDarkColor,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        decoration: InputDecoration(
            hintText: (showFloatingLabel ?? false) ? '' : hint.tr,
            enabled: isEnable ?? true,
            hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: AppConsts.commonFontSizeFactor * 12,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(0.4)),
            label: (showFloatingLabel ?? false)
                ? Text(hint.tr,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 15,
                        color: Colors.black.withOpacity(0.4)))
                : null,
            fillColor: AppColors.kPrimaryColor.withOpacity(0.02),
            filled: true,
            border: inputBorder,
            errorMaxLines: errorMaxLines ?? 1,
            errorBorder: errorInputBorder,
            enabledBorder: inputBorder,
            disabledBorder: inputBorder,
            focusedBorder: inputBorder,
            focusedErrorBorder: errorInputBorder,
            errorStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: AppConsts.commonFontSizeFactor * 12,
                fontWeight: FontWeight.w300,
                color: Colors.red),
            contentPadding: EdgeInsets.symmetric(
                horizontal: inputHorizontalPadding ?? 16.0,
                vertical: inputVerticalPadding ?? 0)),
        inputFormatters: inputFormatter,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
