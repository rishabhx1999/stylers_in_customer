import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import 'package:stylers_in_customer/controller/home/home_controller.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  final _homeController = Get.put(HomeController());
  VoidCallback? leadingIconCallback;

  HomeAppBar({Key? key, this.leadingIconCallback}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
      leading: IconButton(
        onPressed: leadingIconCallback,
        icon: SvgPicture.asset(
          AppIcons.ic_menu,
          height: 14,
          color: AppColors.kPrimaryColor,
        ),
      ),
      automaticallyImplyLeading: false,
      title: Obx(() => Visibility(
            visible: _homeController.isLoggedIn.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage:
                      const AssetImage(AppImages.imgUserPlaceholder),
                  foregroundImage:
                      NetworkImage(_homeController.personImage.value),
                  radius: 18,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  _homeController.personName.value,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 12,
                      color: Colors.black),
                ),
              ],
            ),
          )),
      backgroundColor: Colors.white,
      centerTitle: false,
      titleSpacing: 0,
    );
  }
}
