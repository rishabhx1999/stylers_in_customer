import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/consts/app_images.dart';

import '../../widgets/common/common_button.dart';

class CustomerWalletScreen extends StatelessWidget {
  const CustomerWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text(
          'your_wallet'.tr,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.black,
              fontSize: AppConsts.commonFontSizeFactor * 16),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AppIcons.ic_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Stack(children: [
              AspectRatio(
                aspectRatio: 1.4,
                child: Image.asset(
                  AppImages.img_wallet_balance,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 1.4,
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'your_balance'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: Colors.white.withOpacity(0.65),
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 18),
                          ),
                          const SizedBox(
                            height: 7.0,
                          ),
                          Text(
                            '\$124.53',
                            style:
                                Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ],
                      ))))
            ]),
            const SizedBox(
              height: 51.0,
            ),
            Container(
              height: 205,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset(
                        AppIcons.ic_circle,
                        height: 14.0,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur ',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: Colors.black,
                                  fontSize:
                                      AppConsts.commonFontSizeFactor * 12),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppIcons.ic_circle,
                        height: 14.0,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut lLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut.',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: Colors.black,
                                  fontSize:
                                      AppConsts.commonFontSizeFactor * 12),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppIcons.ic_circle,
                        height: 14.0,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: Colors.black,
                                  fontSize:
                                      AppConsts.commonFontSizeFactor * 12),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppIcons.ic_circle,
                        height: 14.0,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut lLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut.',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: Colors.black,
                                  fontSize:
                                      AppConsts.commonFontSizeFactor * 12),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 38.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'top_up_options'.tr,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.black,fontSize: AppConsts.commonFontSizeFactor * 18,
                    ),
              ),
            ),
            const SizedBox(
              height: 11.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 44.0,
                    width: 44.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1.0, color: AppColors.kPrimaryColor)),
                    child: Center(
                      child: Text(
                        '\$10',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.kPrimaryColor,
                            fontSize: AppConsts.commonFontSizeFactor * 14,fontWeight: FontWeight.w500,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    height: 44.0,
                    width: 44.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1.0, color: AppColors.kPrimaryColor)),
                    child: Center(
                      child: Text(
                        '\$50',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.kPrimaryColor,
                            fontSize: AppConsts.commonFontSizeFactor * 14,fontWeight: FontWeight.w500,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    height: 44.0,
                    width: 44.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1.0, color: AppColors.kPrimaryColor)),
                    child: Center(
                      child: Text(
                        '\$100',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.kPrimaryColor,
                            fontSize: AppConsts.commonFontSizeFactor * 14,fontWeight: FontWeight.w500,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    height: 44.0,
                    width: 44.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1.0, color: AppColors.kPrimaryColor)),
                    child: Center(
                      child: Text(
                        '\$200',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.kPrimaryColor,
                            fontSize: AppConsts.commonFontSizeFactor * 14,fontWeight: FontWeight.w500,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 56.0,
            ),
            CommonButton(
                borderRadius: 2.0,
                horizontalMargin: 20.0,
                text: 'add_money',
                onClick: () {}),
            const SizedBox(
              height: 23.0,
            )
          ],
        ),
      ),
    );
  }
}
