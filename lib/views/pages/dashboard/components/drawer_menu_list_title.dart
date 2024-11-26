import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/size_config.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';

class DrawerMenuListTile extends StatelessWidget {
  Widget? leading;
  Widget? title;
  Widget? subtitle;
  Widget? trailing;
  VoidCallback? onClick;

  DrawerMenuListTile(
      {Key? key,
      this.leading,
      required this.title,
      this.subtitle,
      this.trailing,
      this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
      child: GestureDetector(behavior: HitTestBehavior.opaque,
        onTap: onClick,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading ?? const SizedBox(),
            const SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                title ?? const SizedBox(),
                subtitle ?? const SizedBox(),
              ],
            ),
            const Spacer(),
            trailing ??
                IconButton(
                  padding:  const EdgeInsets.all(2.0),
                  constraints: const BoxConstraints(),
                  onPressed: onClick,
                  icon: SvgPicture.asset(
                    AppIcons.ic_forward_drawer,
                    height: 12,
                  ),
                )
          ],
        ),
      ),
    );
  }
}
