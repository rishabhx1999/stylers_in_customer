import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({Key? key, required this.title, required this.onBackTap})
      : super(key: key);

  final String title;
  final Function() onBackTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: AppColors.appBackgroundColor),
      leading: IconButton(
        onPressed: () {
          onBackTap();
        },
        icon: SvgPicture.asset(
          AppIcons.ic_back,
          height: 14,
        ),
      ),
      title: Text(title),
      titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      backgroundColor: AppColors.appBackgroundColor,
      centerTitle: false,
      titleSpacing: 0,
    );
  }
}
