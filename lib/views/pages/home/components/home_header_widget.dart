import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/config/size_config.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/consts/app_images.dart';


class HomeHeaderWidget extends StatelessWidget {
  RxString city;

  HomeHeaderWidget({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          width: SizeConfig.screenWidth,
          AppImages.img_bg_home_header,
          fit: BoxFit.fill,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.routeSearchLocation);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AppIcons.ic_location_pin,
                      width: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Obx(
                        () => Text(city.value,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    color: AppColors.appBackgroundColor)),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset(
                      AppIcons.ic_arrow_down,
                      height: 8,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'what_are_you_looking_for'.tr,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.white,
                    fontSize: AppConsts.commonFontSizeFactor * 22),
              ),
              const SizedBox(
                height: 8,
              ),
              Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: AppConsts.commonFontSizeFactor * 14,
                      color: Colors.white.withOpacity(0.6))),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 45,
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(AppRoutes.routeSearchScreen);
                    },
                    icon: SvgPicture.asset(AppIcons.ic_search),
                    style: ButtonStyle(
                        alignment: Alignment.centerLeft,
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    label: Text(
                      'search'.tr,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          fontWeight: FontWeight.w300),
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
