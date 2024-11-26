import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/views/pages/inbox/components/inbox_cell_widget.dart';
import '../../../consts/app_images.dart';
import '../../../controller/inbox/inbox_controller.dart';

class InboxScreen extends StatelessWidget {
  InboxScreen({Key? key}) : super(key: key);

  final _inboxController = Get.put(InboxController());

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
            if (_inboxController.isLoggedIn.value)
              Obx(
                () => CircleAvatar(
                  backgroundImage:
                      const AssetImage(AppImages.imgUserPlaceholder),
                  foregroundImage:
                      NetworkImage(_inboxController.profileImage.value),
                  radius: 18,
                ),
              ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'messages'.tr,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: AppConsts.commonFontSizeFactor * 16,
                    color: Colors.black,
                  ),
            ),
          ],
        ),
        titleSpacing: 0,
      ),

      // AppBar(
      //   leadingWidth: 56.0,
      //   titleSpacing: 11.0,
      //   centerTitle: false,
      //   title: Text(
      //     'messages'.tr,
      //     style: Theme.of(context).textTheme.headline6?.copyWith(
      //         color: Colors.black,
      //         fontSize: AppConsts.commonFontSizeFactor * 16),
      //   ),
      //   leading: Row(
      //     children: const [
      //       Expanded(child: SizedBox()),
      //       CircleAvatar(
      //         backgroundImage: AssetImage(AppImages.img_stylists_dummy),
      //         radius: 16.5,
      //       ),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 18.0,
              ),
              Text(
                'unread_messages'.tr,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 9.0,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InboxCellWidget(
                      onTap: () {
                        Get.toNamed(AppRoutes.routeMessages);
                      },
                      isRead: false,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 9.0,
                    );
                  },
                  itemCount: 2),
              const SizedBox(
                height: 18.0,
              ),
              Text(
                'read_messages'.tr,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 9.0,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InboxCellWidget(
                      onTap: () {
                        Get.toNamed(AppRoutes.routeMessages);
                      },
                      isRead: true,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 9.0,
                    );
                  },
                  itemCount: 8),
              const SizedBox(
                height: 38.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
