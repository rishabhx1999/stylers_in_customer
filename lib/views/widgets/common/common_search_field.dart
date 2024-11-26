import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';

class CommonSearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hint;
  Widget? leading;
  Widget? trailing;
  RxBool? isShowTrailing;
  RxBool? isShowLeading;
  final border = InputBorder.none;

  CommonSearchField({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.hint,
    this.leading,
    this.trailing,
    this.isShowTrailing,
    this.isShowLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400, spreadRadius: 0.5, blurRadius: 4.0)
          ]),
      child: Obx(
        () => TextField(
          controller: controller,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              floatingLabelAlignment: FloatingLabelAlignment.center,
              isDense: true,
              alignLabelWithHint: true,
              // contentPadding: const EdgeInsets.all(8),
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(0.4),
                  fontSize: AppConsts.commonFontSizeFactor * 12),
              prefixIcon: isShowLeading?.value ?? false ? leading : null,
              prefixIconConstraints:
                  const BoxConstraints(minHeight: 24, minWidth: 40),
              suffixIcon: isShowTrailing?.value ?? false ? trailing : null,
              suffixIconConstraints:
                  const BoxConstraints(minHeight: 24, minWidth: 40),
              border: border,
              focusedBorder: border,
              enabledBorder: border,
              focusedErrorBorder: border,
              errorBorder: border,
              disabledBorder: border),
          cursorColor: AppColors.kPrimaryDarkColor,
          keyboardType: TextInputType.text,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w300,
                color: Colors.black,
                fontSize: AppConsts.commonFontSizeFactor * 12,
              ),
          onChanged: (text) {
            isShowTrailing?.value = text.isNotEmpty;
            onChanged(text);
          },
        ),
      ),
    );
  }
}
