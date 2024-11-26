
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/size_config.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/model/on_boarding/onboarding_page_model.dart';

class OnBoardingPageView extends StatelessWidget {
  String title ;
  String subtitle ;
  String image ;
  OnBoardingPageView({Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: Text(title.tr,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: AppConsts.commonFontSizeFactor *22
      ),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 18),
          child: Text(subtitle.tr,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: AppConsts.commonFontSizeFactor *12,
              color: AppColors.colorSubHeading
            ),),
        ),
      const  SizedBox(height: 32,),


        Expanded(
          child: Image.asset(image,
          width: SizeConfig.screenWidth,
            fit: BoxFit.fitWidth,
          ),
        )



    ],);
  }
}
