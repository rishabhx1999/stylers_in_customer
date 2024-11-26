import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../consts/app_consts.dart';
import '../../widgets/common/common_button.dart';

class CommonAlertDialog {
  CommonAlertDialog._();

  static showDialog({
    String? title,
    required String message,
    String? negativeText,
    required String positiveText,
    bool? isShowNegButton,
    VoidCallback? negativeBtCallback,
    required VoidCallback positiveBtCallback,
  }) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: CommonDialogContent(
        title: title,
        message: message,
        negativeText: negativeText,
        positiveText: positiveText,
        isShowNegButton: isShowNegButton,
        positiveBtCallback: positiveBtCallback,
        negativeBtCallback: negativeBtCallback,
      ),
    ));
  }
}

class CommonDialogContent extends StatelessWidget {
  CommonDialogContent({
    Key? key,
    this.title,
    required this.message,
    this.negativeText,
    required this.positiveText,
    this.isShowNegButton,
    required this.positiveBtCallback,
    this.negativeBtCallback,
  }) : super(key: key);

  String? title;
  String message;
  String? negativeText;
  String positiveText;
  bool? isShowNegButton;
  VoidCallback positiveBtCallback;
  VoidCallback? negativeBtCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            (title ?? "alert").tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: AppConsts.commonFontSizeFactor * 18,
                color: AppColors.textColorPrimary),
          ),
          Divider(
            color: AppColors.color_D7,
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          Text(
            message.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: AppConsts.commonFontSizeFactor * 16,
                color: AppColors.textColorPrimary),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Visibility(
                visible: isShowNegButton ?? false,
                child: Expanded(
                    child: CommonButton(
                  text: (negativeText ?? "").tr,
                  onClick: negativeBtCallback??(){},
                  backgroundColor: AppColors.color_bt_dialog_cancel,
                  textColor: AppColors.kPrimaryColor,
                  borderRadius: 24,
                )),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: CommonButton(
                text: positiveText.tr,
                onClick:positiveBtCallback,
                borderRadius: 24,
              ))
            ],
          )
        ],
      ),
    );
  }
}
