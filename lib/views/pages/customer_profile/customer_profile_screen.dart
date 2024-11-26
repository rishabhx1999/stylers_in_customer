import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/views/widgets/common/common_button_outline.dart';

import '../../../consts/app_images.dart';
import '../../../controller/customer_profile/customer_profile_controller.dart';
import '../../widgets/common/common_button.dart';

class CustomerProfileScreen extends StatelessWidget {
  CustomerProfileScreen({Key? key}) : super(key: key);

  final _customerProfileController = Get.put(CustomerProfileController());

  Widget buildFollowersStackWidget(int x) {
    return Positioned(
      top: 0,
      left: (x - 1) * 23.0,
      child: Container(
        width: 41.0,
        height: 41.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.color_FA, width: 1.0)),
        child: ClipOval(
          child:
              _customerProfileController.mCustomerFollowers[x - 1].userImage ==
                          null ||
                      _customerProfileController
                              .mCustomerFollowers[x - 1].userImage ==
                          ''
                  ? Image.asset(
                      AppImages.imgUserPlaceholder,
                    )
                  : FadeInImage.assetNetwork(
                      placeholder: AppImages.imgPlaceholder,
                      image: _customerProfileController
                          .mCustomerFollowers[x - 1].userImage!,
                    ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text(
          'your_profile'.tr,
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
      body: Obx(
        () => _customerProfileController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, top: 24, bottom: 16),
                        child: CircleAvatar(
                          backgroundImage:
                              const AssetImage(AppImages.imgUserPlaceholder),
                          foregroundImage: NetworkImage(
                            _customerProfileController
                                .mCustomerProfileImage.value,
                          ),
                          radius: 43.5,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              _customerProfileController.mCustomerName.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 1.0,
                            ),
                            Center(
                              child: Text(
                                _customerProfileController
                                            .mCustomerUsername.value ==
                                        ''
                                    ? ''
                                    : '@${_customerProfileController.mCustomerUsername.value}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        color: Colors.black.withOpacity(
                                          0.5,
                                        ),
                                        fontSize:
                                            AppConsts.commonFontSizeFactor *
                                                18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 13.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
                          child: Obx(
                            () => Text(
                              _customerProfileController
                                  .mCustomerDescription.value,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: AppColors.color_29,
                                      fontSize:
                                          AppConsts.commonFontSizeFactor * 12),
                            ),
                          ),
                        )),
                    // const SizedBox(
                    //   height: 18.96,
                    // ),
                    // Obx(
                    //   () => _customerProfileController.isLoading.value
                    //       ? Shimmer.fromColors(
                    //           baseColor: AppColors.shimmerBaseColor,
                    //           highlightColor: AppColors.shimmerHighlightColor,
                    //           child: Center(
                    //             child: Container(
                    //               height: 41.0,
                    //               width: 250.0,
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(4.0),
                    //                   color: AppColors.shimmerBaseColor),
                    //             ),
                    //           ))
                    //       : _customerProfileController
                    //                   .mCustomerFollowersCount.value ==
                    //               0
                    //           ? Center(
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.center,
                    //                 children: [
                    //                   Text(
                    //                     '0',
                    //                     style: Theme.of(context)
                    //                         .textTheme
                    //                         .headlineSmall
                    //                         ?.copyWith(
                    //                             color:
                    //                                 AppColors.kPrimaryDarkColor,
                    //                             fontSize: AppConsts
                    //                                     .commonFontSizeFactor *
                    //                                 12),fontWeight: FontWeight.w500,
                    //                   ),
                    //                   Text(
                    //                     'followers'.tr,
                    //                     style: Theme.of(context)
                    //                         .textTheme
                    //                         .headline6
                    //                         ?.copyWith(
                    //                             color: Colors.black,
                    //                             fontSize: AppConsts
                    //                                     .commonFontSizeFactor *
                    //                                 12),
                    //                   )
                    //                 ],
                    //               ),
                    //             )
                    //           : Row(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 Stack(children: [
                    //                   SizedBox(
                    //                     width: _customerProfileController
                    //                                 .mCustomerFollowersCount
                    //                                 .value ==
                    //                             0
                    //                         ? 0
                    //                         : 41.0 +
                    //                             (_customerProfileController
                    //                                         .mCustomerFollowersCount
                    //                                         .value -
                    //                                     1) *
                    //                                 23.0,
                    //                     height: 41.0,
                    //                   ),
                    //                   _customerProfileController
                    //                           .mCustomerFollowers.isNotEmpty
                    //                       ? buildFollowersStackWidget(1)
                    //                       : const SizedBox(),
                    //                   _customerProfileController
                    //                               .mCustomerFollowers.length >=
                    //                           2
                    //                       ? buildFollowersStackWidget(2)
                    //                       : const SizedBox(),
                    //                   _customerProfileController
                    //                               .mCustomerFollowers.length >=
                    //                           3
                    //                       ? buildFollowersStackWidget(3)
                    //                       : const SizedBox(),
                    //                   _customerProfileController
                    //                               .mCustomerFollowers.length >=
                    //                           4
                    //                       ? buildFollowersStackWidget(4)
                    //                       : const SizedBox(),
                    //                   _customerProfileController
                    //                               .mCustomerFollowers.length >=
                    //                           5
                    //                       ? buildFollowersStackWidget(5)
                    //                       : const SizedBox(),
                    //                   _customerProfileController
                    //                               .mCustomerFollowers.length >=
                    //                           6
                    //                       ? buildFollowersStackWidget(6)
                    //                       : const SizedBox(),
                    //                   _customerProfileController
                    //                               .mCustomerFollowers.length >=
                    //                           7
                    //                       ? buildFollowersStackWidget(7)
                    //                       : const SizedBox(),
                    //                   _customerProfileController
                    //                               .mCustomerFollowers.length >=
                    //                           8
                    //                       ? buildFollowersStackWidget(8)
                    //                       : const SizedBox(),
                    //                 ]),
                    //                 const SizedBox(
                    //                   width: 5.0,
                    //                 ),
                    //                 Column(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       _customerProfileController
                    //                           .mCustomerFollowersCount.value
                    //                           .toString(),
                    //                       style: Theme.of(context)
                    //                           .textTheme
                    //                           .headline6
                    //                           ?.copyWith(
                    //                               color: AppColors
                    //                                   .kPrimaryDarkColor,
                    //                               fontSize: AppConsts
                    //                                       .commonFontSizeFactor *
                    //                                   12),
                    //                     ),
                    //                     Text(
                    //                       'followers'.tr,
                    //                       style: Theme.of(context)
                    //                           .textTheme
                    //                           .headline6
                    //                           ?.copyWith(
                    //                               color: Colors.black,
                    //                               fontSize: AppConsts
                    //                                       .commonFontSizeFactor *
                    //                                   12),
                    //                     )
                    //                   ],
                    //                 ),
                    //                 const SizedBox(
                    //                   width: 16.0,
                    //                 ),
                    //                 IconButton(
                    //                     onPressed: () {
                    //                       Get.toNamed(
                    //                         AppRoutes.routeFollowers,
                    //                       );
                    //                     },
                    //                     icon: SvgPicture.asset(
                    //                       AppIcons.ic_arrow_forward,
                    //                     )),
                    //                 // Container(
                    //                 //   width: 39.0,
                    //                 //   decoration: const BoxDecoration(shape: BoxShape.circle),
                    //                 //   child: Center(
                    //                 //     child: SvgPicture.asset(AppIcons.ic_arrow_forward),
                    //                 //   ),
                    //                 // ),
                    //                 // Container(child: SvgPicture.asset(AppIcons.ic_arrow_forward)),
                    //                 // IconButton(
                    //                 //     onPressed: () {
                    //                 //       Get.toNamed(AppRoutes.routeFollowers);
                    //                 //     },
                    //                 //     constraints: const BoxConstraints(),
                    //                 //     padding: EdgeInsets.zero,
                    //                 //     icon: SvgPicture.asset(AppIcons.ic_arrow_forward))
                    //               ],
                    //             ),
                    // ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CommonButton(
                        height: 40.0,
                        borderRadius: 20.0,
                        horizontalMargin: 20.0,
                        text: 'edit',
                        onClick: () {
                          Get.toNamed(AppRoutes.routeEditProfile);
                        }),
                  ],
                ),
              ),
      ),
    );
  }
}
