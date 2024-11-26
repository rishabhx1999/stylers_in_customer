import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/controller/appointment/refund_confirmation_controller.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/common/common_button.dart';

class RefundConfirmationScreen extends StatelessWidget {
  final _refundConfirmationController = Get.put(RefundConfirmationController());

  RefundConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              AppIcons.ic_profile_verify,
              height: 83.0,
            ),
          ),
          const SizedBox(
            height: 21.0,
          ),
          Text(
            'your_request_has_been_received'.tr,
            style: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'delivery_message'.tr,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: AppConsts.commonFontSizeFactor * 12),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: 84.0,
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 33.0),
        child: CommonButton(
          text: 'ok'.tr,
          borderRadius: 2.0,
          onClick: () {
            Get.until((route) =>
                route.settings.name ==
                _refundConfirmationController.okRedirectRoute);
          },
          horizontalMargin: 0,
        ),
      ),
    );
  }
}
