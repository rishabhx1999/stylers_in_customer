import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../config/app_colors.dart';
import '../../utils/enums/media_type.dart';
import '../widgets/common/common_button.dart';
import '../widgets/common/common_button_outline.dart';

class CameraBottomSheet {
  static show(
      {required BuildContext context,
      required Function takePhotoOrShootVideo}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CameraBottomSheetContent(
            takePhotoOrShootVideo: takePhotoOrShootVideo,
          );
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))));
  }
}

class CameraBottomSheetContent extends StatelessWidget {
  CameraBottomSheetContent({Key? key, required this.takePhotoOrShootVideo})
      : super(key: key);

  Function takePhotoOrShootVideo;

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
                Navigator.of(context).pop();
                takePhotoOrShootVideo(MediaType.photo);
              }),
          const SizedBox(
            height: 8,
          ),
          CommonButton(
              text: 'shoot_a_video'.tr,
              onClick: () {
                Navigator.of(context).pop();
                takePhotoOrShootVideo(MediaType.video);
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
