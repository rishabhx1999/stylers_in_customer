import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_formatters.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import 'package:stylers_in_customer/controller/edit_profile/edit_profile_controller.dart';
import 'package:stylers_in_customer/utils/validations.dart';

import '../../bottom_sheets/take_image_bottom_sheet.dart';
import '../../widgets/common/common_button.dart';
import '../../widgets/common/common_input_field.dart';

class EditProfileScreen extends StatelessWidget {
  final _editProfileController = Get.put(EditProfileController());

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            'edit_profile'.tr,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                color: Colors.black,
                fontSize: AppConsts.commonFontSizeFactor * 16),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset(AppIcons.ic_back)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _editProfileController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12.0,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        const SizedBox(
                          width: 98.0,
                          height: 98.0,
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Obx(
                            () => CircleAvatar(
                              radius: 43.5,
                              backgroundImage: const AssetImage(
                                  AppImages.imgUserPlaceholder),
                              foregroundImage:
                                  _editProfileController.selectedImage.value !=
                                          null
                                      ? FileImage(File(_editProfileController
                                          .selectedImage.value!.path))
                                      : NetworkImage(_editProfileController
                                          .profileImage.value) as ImageProvider,
                            ),
                          ),
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                                onPressed: () {
                                  TakeImageBottomSheet.show(
                                      context: context,
                                      imageSource: (source) {
                                        Navigator.of(context).pop();
                                        _editProfileController.picImage(source);
                                      });
                                },
                                icon: Container(
                                    width: 31.0,
                                    height: 31.0,
                                    decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColor,
                                        shape: BoxShape.circle),
                                    child: const Center(
                                        child: Icon(
                                      Icons.edit,
                                      size: 18.0,
                                      color: Colors.white,
                                    )))))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  Text(
                    'first_name'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  CommonInputField(
                    controller: _editProfileController.firstNameController,
                    hint: 'first_name',
                    marginLeft: 0,
                    marginRight: 0,
                    marginTop: 0,
                    marginBottom: 0,
                    inputType: TextInputType.name,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(
                          AppFormatters.validNameExp)
                    ],
                    validator: Validations.checkFirstNameValidations,
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    'last_name'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  CommonInputField(
                    controller: _editProfileController.lastNameController,
                    hint: 'last_name',
                    marginLeft: 0,
                    marginRight: 0,
                    marginTop: 0,
                    marginBottom: 0,
                    inputType: TextInputType.name,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(
                          AppFormatters.validNameExp)
                    ],
                    validator: Validations.checkLastNameValidations,
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    'email'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  CommonInputField(
                    isEnable: false,
                    controller: _editProfileController.emailController,
                    hint: 'email',
                    marginLeft: 0,
                    marginRight: 0,
                    marginTop: 0,
                    marginBottom: 0,
                    inputType: TextInputType.emailAddress,
                    validator: Validations.checkEmailValidations,
                  ),
                  // const SizedBox(
                  //   height: 18.0,
                  // ),
                  // Text(
                  //   'address'.tr,
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .headline6
                  //       ?.copyWith(color: Colors.black),
                  // ),
                  // const SizedBox(
                  //   height: 7.0,
                  // ),
                  // CommonInputField(
                  //   controller: _editProfileController.addressController,
                  //   hint: 'address',
                  //   marginLeft: 0,
                  //   marginRight: 0,
                  //   marginTop: 0,
                  //   marginBottom: 0,
                  //   inputType: TextInputType.text,
                  //   validator: Validations.checkAddressValidations,
                  // ),
                  // const SizedBox(
                  //   height: 14.0,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Text(
                  //           'town_city'.tr,
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .headline6
                  //               ?.copyWith(color: Colors.black),
                  //         ),
                  //         const SizedBox(
                  //           height: 7.0,
                  //         ),
                  //         SizedBox(
                  //           width: 100.0,
                  //           child: CommonInputField(
                  //             isEnable: false,
                  //             marginTop: 0,
                  //             marginLeft: 0,
                  //             marginBottom: 0,
                  //             marginRight: 0,
                  //             controller: _editProfileController.cityController,
                  //             hint: 'town_city',
                  //             inputType: TextInputType.name,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     const SizedBox(
                  //       width: 28.0,
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Text(
                  //           'state'.tr,
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .headline6
                  //               ?.copyWith(color: Colors.black),
                  //         ),
                  //         const SizedBox(
                  //           height: 7.0,
                  //         ),
                  //         SizedBox(
                  //           width: 100.0,
                  //           child: CommonInputField(
                  //             isEnable: false,
                  //             marginTop: 0,
                  //             marginLeft: 0,
                  //             marginBottom: 0,
                  //             marginRight: 0,
                  //             controller:
                  //                 _editProfileController.provinceController,
                  //             hint: 'state',
                  //             inputType: TextInputType.name,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 14.0,
                  // ),
                  // Text(
                  //   'postal_code'.tr,
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .headline6
                  //       ?.copyWith(color: Colors.black),
                  // ),
                  // const SizedBox(
                  //   height: 7.0,
                  // ),
                  // SizedBox(
                  //   width: 100.0,
                  //   child: CommonInputField(
                  //     onChanged: (value) {
                  //       _editProfileController.cityController.clear();
                  //       _editProfileController.provinceController.clear();
                  //       _editProfileController.mPostalCode.value = value;
                  //     },
                  //     errorMaxLines: 2,
                  //     controller: _editProfileController.postalCodeController,
                  //     hint: 'postal_code',
                  //     marginLeft: 0,
                  //     marginRight: 0,
                  //     marginTop: 0,
                  //     marginBottom: 0,
                  //     inputType: TextInputType.number,
                  //     validator: Validations.checkPostalCodeValidations,
                  //     inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 32.0),
          child: Obx(
            () => _editProfileController.isLoading.value
                ? Container(
                    height: 51,
                    width: 51,
                    padding: const EdgeInsets.all(8),
                    child: const Center(child: CircularProgressIndicator()))
                : CommonButton(
                    horizontalMargin: 0,
                    borderRadius: 2.0,
                    text: 'save',
                    onClick: () {
                      if (_editProfileController.formKey.currentState!
                          .validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _editProfileController.saveChanges();
                      }
                    }),
          ),
        ),
      ),
    );
  }
}
