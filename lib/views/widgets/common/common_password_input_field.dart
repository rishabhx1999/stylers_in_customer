import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';

class CommonPasswordInputField extends StatelessWidget {
  String hint;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController controller;
  TextInputType? inputType;
  List<TextInputFormatter>? inputFormatter;
  RxBool isObscure = true.obs;
  bool? isShowHelperText;
  double? horizontalMargin;
  double? verticalMargin;
  bool isShowSuffix;

  var inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.kPrimaryColor.withOpacity(0.28)));

  CommonPasswordInputField(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.isShowSuffix,
      this.onChanged,
      this.validator,
      this.inputType,
      this.inputFormatter,
      this.isShowHelperText,
      this.horizontalMargin,
      this.verticalMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin ?? 16.0, vertical: verticalMargin ?? 8),
      child: Obx(
        () => TextFormField(
          controller: controller,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.black),
          keyboardType: TextInputType.visiblePassword,
          cursorColor: AppColors.kPrimaryDarkColor,
          obscureText: isObscure.value,
          obscuringCharacter: '*',
          decoration: InputDecoration(
              hintText: hint.tr,
              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: AppConsts.commonFontSizeFactor * 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(0.4)),
              suffixIcon: isShowSuffix?IconButton(
                  onPressed: () {
                    isObscure.value = !isObscure.value;
                  },
                  icon: Icon(
                      isObscure.value ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.kPrimaryColor)):const SizedBox(),
              filled: true,
              fillColor: AppColors.kPrimaryColor.withOpacity(0.02),
              helperText: isShowHelperText ?? true
                  ? 'message_password_helper'.tr
                  : null,errorMaxLines: 3,
              helperMaxLines: 2,
              helperStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: AppConsts.commonFontSizeFactor * 9,
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(0.3)),
              errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: AppConsts.commonFontSizeFactor * 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.red),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: inputBorder,
              errorBorder: inputBorder,
              enabledBorder: inputBorder,
              disabledBorder: inputBorder,
              focusedBorder: inputBorder,
              focusedErrorBorder: inputBorder),
          inputFormatters: inputFormatter,
          validator: validator,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
