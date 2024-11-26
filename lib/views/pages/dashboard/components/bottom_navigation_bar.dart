import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/size_config.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/model/dashboard/home_bottom_nav_model.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final BuildContext context;
  final int selectedIndex;
  final Function(int) onChange;
  final List<HomeBottomNavModel> tabs;

  CustomBottomNavigationBar({
    Key? key,
    required this.context,
    required this.selectedIndex,
    required this.tabs,
    required this.onChange,
  }) : super(key: key);

  get widget => null;

  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItemList = [];

    for (var i = 0; i < tabs.length; i++) {
      navBarItemList.add(buildNavBarItem(tabs[i].icon, tabs[i].title, i));
    }

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navBarItemList,
      ),
    );
  }

  Widget buildNavBarItem(String icon, String label, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onChange(index);
      },
      child: Container(
        height: 70,
        width: SizeConfig.screenWidth / tabs.length,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 2,
                decoration: BoxDecoration(
                    color: index == selectedIndex
                        ? AppColors.kPrimaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(1.0)),
              ),
              const SizedBox(
                height: 8,
              ),
              SvgPicture.asset(
                icon,
                height: 20,
                color: index == selectedIndex
                    ? AppColors.kPrimaryColor
                    : AppColors.color_CC,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(label.tr,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppConsts.commonFontSizeFactor * 13,
                        color: index == selectedIndex
                            ? AppColors.kPrimaryColor
                            : AppColors.color_CC,
                      ))
            ]),
      ),
    );
  }
}
