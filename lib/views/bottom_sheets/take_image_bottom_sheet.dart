import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/app_colors.dart';
import '../widgets/common/common_button.dart';
import '../widgets/common/common_button_outline.dart';

enum ImageSourceOptions { camera, gallery }

class TakeImageBottomSheet {
  static show(
      {required BuildContext context,
      required Function(ImageSource) imageSource}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return TakeImageBottomSheetContent(
            imageSource: imageSource,
          );
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))));
  }
}

class TakeImageBottomSheetContent extends StatelessWidget {
  TakeImageBottomSheetContent({Key? key, required this.imageSource})
      : super(key: key);

  Function(ImageSource) imageSource;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 32,
          ),
          CommonButton(
              text: 'take_a_photo'.tr,
              onClick: () {
                imageSource(ImageSource.camera);
              }),
          const SizedBox(
            height: 8,
          ),
          CommonButton(
              text: 'choose_from_gallery'.tr,
              onClick: () {
                imageSource(ImageSource.gallery);
              }),
          const SizedBox(
            height: 24,
          ),
          CommonButtonOutline(
            text: 'cancel'.tr,
            clickAction: () {
              Navigator.of(context).pop();
            },
            borderColor: Colors.grey.shade400,
            textColor: AppColors.textColorPrimary,
            elevation: 0,
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
