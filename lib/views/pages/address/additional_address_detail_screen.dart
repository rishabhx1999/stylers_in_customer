import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../consts/app_consts.dart';
import '../../../controller/address/additional_address_detail_controller.dart';
import '../../../utils/validations.dart';
import '../../widgets/common/common_app_bar.dart';
import '../../widgets/common/common_button.dart';
import '../../widgets/common/common_input_field.dart';

class AdditionalAddressDetailScreen extends StatelessWidget {
  AdditionalAddressDetailScreen({Key? key}) : super(key: key);

  final _additionalAddressDetailController =
      Get.put(AdditionalAddressDetailController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarColor: AppColors.appBackgroundColor));
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        appBar: CommonAppBar(
            title: 'confirm_your_address'.tr,
            onBackTap: () {
              Get.back();
            }),
        body: SingleChildScrollView(
          child: Form(
            key: _additionalAddressDetailController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Text(
                    'where_can_we_find_you'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 15,
                        color: AppColors.color_B8),
                  ),
                ),
                CommonInputField(
                  controller:
                      _additionalAddressDetailController.addressLine1Controller,
                  hint: 'street_address_line_1'.tr,
                  showFloatingLabel: true,
                  textCapitalization: TextCapitalization.sentences,
                  validator: Validations.checkEmptyFieldValidation,
                ),
                CommonInputField(
                    controller:
                        _additionalAddressDetailController.addressLine2Controller,
                    hint: 'street_address_line_2'.tr,
                    showFloatingLabel: true,
                    textCapitalization: TextCapitalization.sentences,
                    validator: Validations.checkEmptyFieldValidation),
                CommonInputField(
                    controller: _additionalAddressDetailController.cityController,
                    hint: 'city'.tr,
                    isEnable: false,
                    showFloatingLabel: true,
                    validator: Validations.checkEmptyFieldValidation),
                CommonInputField(
                    controller:
                        _additionalAddressDetailController.zipcodeController,
                    hint: 'zipcode'.tr,
                    isEnable: false,
                    showFloatingLabel: true,
                    validator: Validations.checkEmptyFieldValidation)
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: 16, bottom: Platform.isIOS ? 32 : 16),
          child: CommonButton(
              text: 'continue'.tr,
              onClick: () {
                _additionalAddressDetailController.validateAddressData();
              }),
        ),
      ),
    );
  }
}
