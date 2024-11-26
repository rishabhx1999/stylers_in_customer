import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/views/pages/notifications/components/notification_widget.dart';

import '../../../consts/app_images.dart';
import '../../../controller/notifications/notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  final _notificationsController = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: const SizedBox(
          width: 8,
        ),
        leadingWidth: 24,
        title: Row(
          children: [
            if (_notificationsController.isLoggedIn.value)
              Obx(
                () => CircleAvatar(
                  backgroundImage:
                      const AssetImage(AppImages.imgUserPlaceholder),
                  foregroundImage:
                      NetworkImage(_notificationsController.profileImage.value),
                  radius: 18,
                ),
              ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'notification'.tr,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: AppConsts.commonFontSizeFactor * 16,
                    color: Colors.black,
                  ),
            ),
          ],
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return NotificationWidget();
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    indent: 1.0,
                    height: 0.83,
                    thickness: 0.83,
                    color: Colors.black.withOpacity(0.1),
                  );
                },
                itemCount: 8),
            Divider(
              indent: 1.0,
              height: 0.83,
              thickness: 0.83,
              color: Colors.black.withOpacity(0.1),
            )
          ],
        ),
      ),
    );
  }
}
