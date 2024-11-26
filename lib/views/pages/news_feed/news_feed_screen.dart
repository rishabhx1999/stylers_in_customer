import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import 'package:stylers_in_customer/controller/news_feed/news_feed_controller.dart';

import '../../widgets/common/common_news_feed_widget.dart';

class NewsFeedScreen extends StatelessWidget {
  NewsFeedScreen({Key? key}) : super(key: key);
  final _newsFeedController = Get.put(NewsFeedController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: const SizedBox(
          width: 8,
        ),
        leadingWidth: 24,
        title: Obx(
          () => Visibility(
            visible: _newsFeedController.isLoggedIn.value,
            child: Row(
              children: [
                Obx(
                  () => CircleAvatar(
                    backgroundImage:
                        const AssetImage(AppImages.imgUserPlaceholder),
                    foregroundImage:
                        NetworkImage(_newsFeedController.personImage.value),
                    radius: 18,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'news_feed'.tr,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontSize: AppConsts.commonFontSizeFactor * 16,
                        color: Colors.black,
                      ),
                ),
              ],
            ),
          ),
        ),
        titleSpacing: 0,
      ),
      body: Obx(
        () => ListView.separated(
            shrinkWrap: true,
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 24),
            itemBuilder: (context, index) {
              return CommonNewsFeedWidget(
                toggleFavoriteStatus:
                    _newsFeedController.toggleFavoriteStatusRemote,
                postData: _newsFeedController.posts[index],
                isLoggedIn: _newsFeedController.isLoggedIn.value,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16.0,
              );
            },
            itemCount: _newsFeedController.posts.length),
      ),
    );
  }
}
