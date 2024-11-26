import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import 'package:stylers_in_customer/controller/home/home_controller.dart';
import 'package:stylers_in_customer/model/services/services_res_model.dart';
import 'package:stylers_in_customer/views/pages/home/components/home_header_widget.dart';
import 'package:stylers_in_customer/views/pages/home/components/home_app_bar.dart';
import 'package:stylers_in_customer/views/pages/home/components/service_widget.dart';
import '../../../model/login/login_res_model.dart';
import '../../widgets/common/common_service_widget_shimmer.dart';
import '../../widgets/common/common_shop_grid_widget.dart';
import '../../widgets/common/common_stylist_widget_shimmer.dart';
import '../../widgets/common/stylist_widget_home.dart';
import 'components/shop_widget_shimmer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: HomeAppBar(
        leadingIconCallback: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HomeHeaderWidget(
              city: _homeController.city,
            ),
            const SizedBox(
              height: 2.0,
            ),
            Obx(
              () =>
                  // ? AspectRatio(
                  //     aspectRatio: 16 / 5,
                  //     child: Shimmer.fromColors(
                  //       baseColor: AppColors.shimmerBaseColor,
                  //       highlightColor: AppColors.shimmerHighlightColor,
                  //       child: Container(
                  //         margin: const EdgeInsets.symmetric(
                  //             horizontal: 16, vertical: 8),
                  //         decoration: BoxDecoration(
                  //             color: AppColors.shimmerBaseColor,
                  //             borderRadius: BorderRadius.circular(4)),
                  //       ),
                  //     ),
                  //   )
                  Visibility(
                visible: _homeController.banners.isNotEmpty,
                child: CarouselSlider(
                  items: _homeController.banners.map((banner) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(0, 0),
                                spreadRadius: 3,
                                blurRadius: 3,
                                blurStyle: BlurStyle.solid),
                          ]),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: banner.image != null
                              ? FadeInImage.assetNetwork(
                                  placeholder: AppImages.imgPlaceholder,
                                  image: banner.image!,
                                  fit: BoxFit.cover,
                                ) /*Image.network(
                                  banner.image!,
                                  fit: BoxFit.fitWidth,
                                )*/
                              : Image.asset(
                                  AppImages.imgPlaceholder,
                                  fit: BoxFit.fitWidth,
                                )),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    aspectRatio: 16 / 5,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (value, reason) {},
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'services'.tr,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: AppConsts.commonFontSizeFactor * 14),
                  ),
                  Obx(
                    () => Visibility(
                      visible: _homeController.services.isNotEmpty,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.routeServiceCategories,
                              arguments: _homeController.services);
                        },
                        child: Text(
                          'show_all'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 12,
                                  color: AppColors.kPrimaryColor,
                                  decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Obx(
              () => Visibility(
                visible: _homeController.isLoading.value ||
                    (_homeController.services.isNotEmpty &&
                        _homeController.isLoading.value == false),
                child: SizedBox(
                  height: 87,
                  child: Obx(
                    () => ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shrinkWrap: true,
                      itemCount: _homeController.isLoading.value
                          ? 4
                          : (_homeController.services.length > 4
                              ? 4
                              : _homeController.services.length),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return _homeController.isLoading.value
                            ? const CommonServiceWidgetShimmer()
                            : ServiceWidget(
                                service: _homeController.services[index],
                                onTap: (Service service) {
                                  Get.toNamed(AppRoutes.routeSearchScreen,
                                      arguments: {
                                        AppConsts.keySearchKeyword:
                                            service.name,
                                      });
                                },
                              );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Obx(() => Visibility(
                  visible: _homeController.isLoading.value == false &&
                      _homeController.services.isEmpty,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 32.0,
                        ),
                        Text(
                          'no_services'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 12,
                                  color: Colors.black),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'popular_stylists'.tr,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: AppConsts.commonFontSizeFactor * 14,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _homeController.isLoading.value
                          ? const CommonStylistWidgetShimmer()
                          : StylistWidgetHome(
                              user: _homeController.popularStylists[index],
                              onTab: (User user) {
                                Get.toNamed(AppRoutes.routeProfileDetailScreen,
                                    arguments: {
                                      AppConsts.keyProviderId: user.id,
                                    });
                              },
                            );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 8.0,
                      );
                    },
                    itemCount: _homeController.isLoading.value
                        ? 3
                        : (_homeController.popularStylists.length > 3
                            ? 3
                            : _homeController.popularStylists.length)),
              ),
            ),
            Obx(() => Visibility(
                  visible: _homeController.isLoading.value == false &&
                      _homeController.popularStylists.isEmpty,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 32.0,
                        ),
                        Text(
                          'no_stylists'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 12,
                                  color: Colors.black),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(
              height: 7,
            ),
            Obx(
              () => Visibility(
                visible: _homeController.popularStylists.isNotEmpty,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.routeStylistsList);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.kPrimaryColor.withOpacity(0.05))),
                      child: Text(
                        'see_more'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: AppColors.kPrimaryColor),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'popular_shops'.tr,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppConsts.commonFontSizeFactor * 14),
                  ),
                  Obx(
                    () => Visibility(
                      visible: _homeController.nearbyShops.isNotEmpty,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.routeShopsList);
                        },
                        child: Text(
                          "show_all".tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 12,
                                  color: AppColors.kPrimaryColor,
                                  decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Obx(
              () => Visibility(
                visible: _homeController.isLoading.value ||
                    (_homeController.nearbyShops.isNotEmpty &&
                        _homeController.isLoading.value == false),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    height: 195,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20.0,
                        ),
                        Obx(
                          () => ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return _homeController.isLoading.value
                                    ? const ShopWidgetShimmer()
                                    : CommonShopGridWidget(
                                        shopOwner:
                                            _homeController.nearbyShops[index],
                                        onTap: (User user) {
                                          Get.toNamed(
                                              AppRoutes
                                                  .routeProfileDetailScreen,
                                              arguments: {
                                                AppConsts.keyProviderId:
                                                    user.id,
                                              });
                                        },
                                      );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 6.0,
                                );
                              },
                              itemCount: _homeController.isLoading.value
                                  ? 3
                                  : (_homeController.nearbyShops.length > 3
                                      ? 3
                                      : _homeController.nearbyShops.length)),
                        ),
                        const SizedBox(
                          width: 20.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Obx(() => Visibility(
                  visible: _homeController.isLoading.value == false &&
                      _homeController.nearbyShops.isEmpty,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 32.0,
                        ),
                        Text(
                          'no_shops'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 12,
                                  color: Colors.black),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
