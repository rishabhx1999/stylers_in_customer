import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/controller/profile_detail/profile_detail_controller.dart';
import '../../../consts/app_images.dart';
import '../../widgets/common/common_button.dart';
import '../../widgets/common/review_widget.dart';
import 'components/service_detail_widget.dart';

class ProfileDetailScreen extends StatelessWidget {
  final _profileDetailController = Get.put(ProfileDetailController());

  ProfileDetailScreen({Key? key}) : super(key: key);

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
          child: _profileDetailController.mProviderFollowers[x - 1].userImage ==
                      null ||
                  _profileDetailController
                          .mProviderFollowers[x - 1].userImage ==
                      ''
              ? Image.asset(
                  AppImages.imgUserPlaceholder,
                )
              : FadeInImage.assetNetwork(
                  placeholder: AppImages.imgUserPlaceholder,
                  image: _profileDetailController
                      .mProviderFollowers[x - 1].userImage!,
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
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        title: Text(
          'profile'.tr,
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
        () => _profileDetailController.isProfileLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              )
            : Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, top: 24, bottom: 16),
                            child: CircleAvatar(
                              backgroundImage: const AssetImage(
                                  AppImages.imgUserPlaceholder),
                              foregroundImage: NetworkImage(
                                _profileDetailController
                                    .mProviderProfileImage.value,
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
                                  _profileDetailController.mProviderName.value,
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
                                    '@${_profileDetailController.mProviderUsername.value}',
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
                            const SizedBox(
                              width: 7.3,
                            ),
                            Obx(() => Visibility(
                                  visible: _profileDetailController
                                      .mIsProviderVerified.value,
                                  child: Column(children: [
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    SvgPicture.asset(AppIcons.ic_profile_verify)
                                  ]),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 13.0,
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Center(
                              child: Obx(
                                () => Text(
                                  _profileDetailController
                                      .mProviderDescription.value,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                          color: AppColors.color_29,
                                          fontSize:
                                              AppConsts.commonFontSizeFactor *
                                                  12),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 11.0,
                        ),
                        Obx(
                          () => _profileDetailController.isProfileLoading.value
                              ? Shimmer.fromColors(
                                  baseColor: AppColors.shimmerBaseColor,
                                  highlightColor:
                                      AppColors.shimmerHighlightColor,
                                  child: Center(
                                    child: Container(
                                      height: 22.0,
                                      width: 180.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          color: AppColors.shimmerBaseColor),
                                    ),
                                  ))
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AbsorbPointer(
                                      child: RatingBar.builder(
                                        onRatingUpdate: (rating) {},
                                        initialRating: _profileDetailController
                                            .mProviderAverageRating.value,
                                        minRating: 0.5,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 22.0,
                                        wrapAlignment: WrapAlignment.center,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        itemBuilder: (context, _) =>
                                            SvgPicture.asset(
                                          AppIcons.ic_star,
                                          height: 22.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      '(${_profileDetailController.mProviderAverageRating.value})',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: Colors.black,
                                        fontSize: AppConsts.commonFontSizeFactor * 12,fontWeight: FontWeight.w500,),
                                    )
                                  ],
                                ),
                        ),
                        const SizedBox(
                          height: 18.96,
                        ),
                        Obx(
                          () => _profileDetailController.isProfileLoading.value
                              ? Shimmer.fromColors(
                                  baseColor: AppColors.shimmerBaseColor,
                                  highlightColor:
                                      AppColors.shimmerHighlightColor,
                                  child: Center(
                                    child: Container(
                                      height: 41.0,
                                      width: 250.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          color: AppColors.shimmerBaseColor),
                                    ),
                                  ))
                              : _profileDetailController
                                          .mProviderFollowersCount.value ==
                                      0
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '0',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                    color: AppColors
                                                        .kPrimaryDarkColor,fontSize: AppConsts.commonFontSizeFactor * 12,fontWeight: FontWeight.w500,),
                                          ),
                                          Text(
                                            'followers'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                    color: Colors.black,fontSize: AppConsts.commonFontSizeFactor * 12,fontWeight: FontWeight.w500,),
                                          )
                                        ],
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Stack(children: [
                                          SizedBox(
                                            width: _profileDetailController
                                                        .mProviderFollowersCount
                                                        .value ==
                                                    0
                                                ? 0
                                                : 41.0 +
                                                    (_profileDetailController
                                                                .mProviderFollowersCount
                                                                .value -
                                                            1) *
                                                        23.0,
                                            height: 41.0,
                                          ),
                                          _profileDetailController
                                                  .mProviderFollowers.isNotEmpty
                                              ? buildFollowersStackWidget(1)
                                              : const SizedBox(),
                                          _profileDetailController
                                                      .mProviderFollowers
                                                      .length >=
                                                  2
                                              ? buildFollowersStackWidget(2)
                                              : const SizedBox(),
                                          _profileDetailController
                                                      .mProviderFollowers
                                                      .length >=
                                                  3
                                              ? buildFollowersStackWidget(3)
                                              : const SizedBox(),
                                          _profileDetailController
                                                      .mProviderFollowers
                                                      .length >=
                                                  4
                                              ? buildFollowersStackWidget(4)
                                              : const SizedBox(),
                                          _profileDetailController
                                                      .mProviderFollowers
                                                      .length >=
                                                  5
                                              ? buildFollowersStackWidget(5)
                                              : const SizedBox(),
                                          _profileDetailController
                                                      .mProviderFollowers
                                                      .length >=
                                                  6
                                              ? buildFollowersStackWidget(6)
                                              : const SizedBox(),
                                          _profileDetailController
                                                      .mProviderFollowers
                                                      .length >=
                                                  7
                                              ? buildFollowersStackWidget(7)
                                              : const SizedBox(),
                                          _profileDetailController
                                                      .mProviderFollowers
                                                      .length >=
                                                  8
                                              ? buildFollowersStackWidget(8)
                                              : const SizedBox(),
                                        ]),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _profileDetailController
                                                  .mProviderFollowersCount.value
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .kPrimaryDarkColor,
                                                      fontSize: AppConsts
                                                              .commonFontSizeFactor *
                                                          12),
                                            ),
                                            Text(
                                              'followers'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                      color: Colors.black,fontSize: AppConsts.commonFontSizeFactor * 12,fontWeight: FontWeight.w500,),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 16.0,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.toNamed(
                                                  AppRoutes.routeFollowers,
                                                  arguments: {
                                                    AppConsts.keyProviderId:
                                                        _profileDetailController
                                                            .mProviderId
                                                  });
                                            },
                                            icon: SvgPicture.asset(
                                              AppIcons.ic_arrow_forward,
                                            )),
                                        // Container(
                                        //   width: 39.0,
                                        //   decoration: const BoxDecoration(shape: BoxShape.circle),
                                        //   child: Center(
                                        //     child: SvgPicture.asset(AppIcons.ic_arrow_forward),
                                        //   ),
                                        // ),
                                        // Container(child: SvgPicture.asset(AppIcons.ic_arrow_forward)),
                                        // IconButton(
                                        //     onPressed: () {
                                        //       Get.toNamed(AppRoutes.routeFollowers);
                                        //     },
                                        //     constraints: const BoxConstraints(),
                                        //     padding: EdgeInsets.zero,
                                        //     icon: SvgPicture.asset(AppIcons.ic_arrow_forward))
                                      ],
                                    ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Obx(
                          () => _profileDetailController.isProfileLoading.value
                              ? Shimmer.fromColors(
                                  baseColor: AppColors.shimmerBaseColor,
                                  highlightColor:
                                      AppColors.shimmerHighlightColor,
                                  child: Center(
                                    child: Container(
                                      height: 39.0,
                                      width: 300.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          color: AppColors.shimmerBaseColor),
                                    ),
                                  ))
                              : Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width,
                                  height: 39.0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(19.5),
                                              border: Border.all(
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                  width: 2.0)),
                                          child: CommonButton(
                                              borderRadius: 19.5,
                                              backgroundColor:
                                                  AppColors.appBackgroundColor,
                                              horizontalMargin: 0,
                                              textColor:
                                                  AppColors.kPrimaryColor,
                                              text: _profileDetailController
                                                      .mIsFollowing.value
                                                  ? 'following'
                                                  : 'follow',
                                              onClick: () {
                                                _profileDetailController
                                                    .toggleFollow();
                                              }),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.routeMessages);
                                        },
                                        child: Container(
                                          width: 39.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  AppColors.kLightPrimaryColor),
                                          child: Center(
                                            child: SvgPicture.asset(
                                                AppIcons.ic_message),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
                        Divider(
                          thickness: 1.0,
                          indent: 20.0,
                          endIndent: 20.0,
                          color: Colors.black.withOpacity(0.1),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Obx(
                          () => _profileDetailController.isProfileLoading.value
                              ? Shimmer.fromColors(
                                  baseColor: AppColors.shimmerBaseColor,
                                  highlightColor:
                                      AppColors.shimmerHighlightColor,
                                  child: Center(
                                    child: Container(
                                      height: 14.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                          color: AppColors.shimmerBaseColor),
                                    ),
                                  ))
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    'services'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: AppColors.kPrimaryColor,
                                            fontSize:
                                                AppConsts.commonFontSizeFactor *
                                                    14,fontWeight: FontWeight.w500,),
                                  ),
                                ),
                        ),
                        // Center(
                        //   child: Text(
                        //     'no_data_yet'.tr,
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .headlineSmall
                        //         ?.copyWith(color: Colors.black),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        Obx(
                          () => ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _profileDetailController
                                          .mProviderServices.length >
                                      2
                                  ? 2
                                  : _profileDetailController
                                      .mProviderServices.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 2.0,
                                );
                              },
                              itemBuilder: (context, index) {
                                return ServiceDetailWidget(
                                  service: _profileDetailController
                                      .mProviderServices[index],
                                );
                              }),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.kPrimaryColor
                                          .withOpacity(0.05))),
                              child: Text(
                                'see_more'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColors.kPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            AppConsts.commonFontSizeFactor *
                                                12),
                              )),
                        ),
                        const SizedBox(
                          height: 17.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0),
                          child: Text(
                            'portfolio'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: AppColors.kPrimaryColor,
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 14,fontWeight: FontWeight.w500,),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        SizedBox(
                          height: 119.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  if (index == 2) {
                                    return Stack(
                                      children: [
                                        SizedBox(
                                            width: 109.0,
                                            height: 119.0,
                                            child: ClipRRect(
                                              child: Image.asset(
                                                'assets/images/profile_photo.png',
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                        Positioned(
                                            child: Container(
                                          color: AppColors.color_6B
                                              .withOpacity(0.7),
                                          width: 109.0,
                                          height: 119.0,
                                          child: Center(
                                            child: Text(
                                              '+21',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                      color: Colors.white,fontSize: AppConsts.commonFontSizeFactor * 12,fontWeight: FontWeight.w500,),
                                            ),
                                          ),
                                        ))
                                      ],
                                    );
                                  }
                                  return SizedBox(
                                      width: 109.0,
                                      height: 119.0,
                                      child: ClipRRect(
                                        child: Image.asset(
                                          'assets/images/profile_photo.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ));
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 3.0,
                                  );
                                },
                                itemCount: 3),
                          ),
                        ),
                        const SizedBox(
                          height: 23.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0),
                          child: Text(
                            'reviews'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: AppColors.kPrimaryColor,
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 14,fontWeight: FontWeight.w500,),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0),
                          child: Text(
                            'your_review'.tr,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.black.withOpacity(0.67),fontSize: AppConsts.commonFontSizeFactor * 14,
                                  fontWeight: FontWeight.w300,
                                    ),
                          ),
                        ),
                        const SizedBox(
                          height: 2.28,
                        ),
                        Center(
                          child: RatingBar.builder(
                            initialRating:
                                _profileDetailController.mProviderRating.value,
                            minRating: 0.5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 24.65,
                            wrapAlignment: WrapAlignment.center,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 17.65),
                            itemBuilder: (context, index) => SvgPicture.asset(
                              AppIcons.ic_star,
                              height: 24.65,
                            ),
                            onRatingUpdate: (rating) {
                              // _stylistProfileController.mStylistRating.value = rating;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 18.07,
                        ),
                        ListView.separated(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 2,
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.black.withOpacity(0.04),
                                height: 21.0,
                                thickness: 1.0,
                              );
                            },
                            itemBuilder: (context, index) {
                              return const ReviewWidget();
                            }),
                        const SizedBox(
                          height: 3.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.routeReviews);
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.kPrimaryColor
                                          .withOpacity(0.05))),
                              child: Text(
                                'see_all_reviews'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColors.kPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            AppConsts.commonFontSizeFactor *
                                                12),
                              )),
                        ),
                        const SizedBox(
                          height: 26.0,
                        )
                      ],
                    ),
                  ),
                  Obx(() => Visibility(
                        visible: _profileDetailController.isLoading.value,
                        child: Center(
                            child: Container(
                                height: 51,
                                width: 51,
                                padding: const EdgeInsets.all(8),
                                child: const CircularProgressIndicator())),
                      ))
                ],
              ),
      ),
      bottomNavigationBar: Obx(
        () => _profileDetailController.isProfileLoading.value
            ? const SizedBox()
            : Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 94.0,
                padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        text: 'chat',
                        borderRadius: 2.0,
                        onClick: () {},
                        horizontalMargin: 0,
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(2.0),
                            border: Border.all(
                              color: AppColors.kPrimaryColor,
                              width: 1.0,
                            )),
                        child: CommonButton(
                          textColor: AppColors.kPrimaryColor,
                          backgroundColor: Colors.white,
                          borderRadius: 2.0,
                          text: 'book_now',
                          onClick: () {
                            Get.toNamed(AppRoutes.routeCreateAppointment,
                                arguments: {
                                  AppConsts.keyProviderId:
                                      _profileDetailController.mProviderId,
                                  AppConsts.keyProviderRole:
                                      _profileDetailController.mProviderRole,
                                  AppConsts.keyProviderProfileImage:
                                      _profileDetailController
                                          .mProviderProfileImage.value,
                                  AppConsts.keyProviderName:
                                      _profileDetailController
                                          .mProviderName.value
                                });
                          },
                          horizontalMargin: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
