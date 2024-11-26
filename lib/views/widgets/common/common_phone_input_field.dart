import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';

class CommonPhoneInputField extends StatelessWidget {
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
  VoidCallback countryCodePickerCallback;
  var selectedCountry = Rx<Country?>(null);

  var inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.kPrimaryColor.withOpacity(0.28)));

  var errorInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.red));

  CommonPhoneInputField(
      {Key? key,
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
      required this.countryCodePickerCallback,
      required this.selectedCountry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: marginLeft ?? 16,
          right: marginRight ?? 16,
          top: marginTop ?? 8,
          bottom: marginBottom ?? 8),
      child: Stack(
        children: [
          TextFormField(
            controller: controller,
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.black),
            keyboardType: inputType ?? TextInputType.phone,
            cursorColor: AppColors.kPrimaryDarkColor,
            decoration: InputDecoration(
                hintText: hint.tr,
                hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: AppConsts.commonFontSizeFactor * 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.black.withOpacity(0.4)),
                fillColor: AppColors.kPrimaryColor.withOpacity(0.02),
                filled: true,
                border: inputBorder,
                errorBorder: inputBorder,
                enabledBorder: inputBorder,
                disabledBorder: inputBorder,
                focusedBorder: inputBorder,
                focusedErrorBorder: inputBorder,
                errorStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: AppConsts.commonFontSizeFactor * 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.red),
                contentPadding: const EdgeInsets.only(left: 120, right: 16)),
            inputFormatters: inputFormatter,
            validator: validator,
            onChanged: onChanged,
          ),
          Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 16,
                ),
                TextButton.icon(
                    onPressed: countryCodePickerCallback,
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    icon: Text(selectedCountry.value?.flagEmoji ?? ""),
                    label: Text(
                      '+${selectedCountry.value?.phoneCode ?? ''}',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          color: Colors.black.withOpacity(0.4),
                          fontWeight: FontWeight.w300),
                    )),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  width: 1,
                  height: 46,
                  color: AppColors.kPrimaryColor.withOpacity(0.4),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
