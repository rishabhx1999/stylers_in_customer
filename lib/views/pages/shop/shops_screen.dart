import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/controller/shop/shops_screen_controller.dart';

import '../../../model/login/login_res_model.dart';
import '../../widgets/common/common_search_field.dart';
import '../../widgets/common/common_shop_grid_widget.dart';

class ShopsScreen extends StatelessWidget {
  ShopsScreen({Key? key}) : super(key: key);

  final _shopsController = Get.put(ShopsScreenController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));

    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        title: Text(
          'shops'.tr,
          style: Theme.of(context).textTheme.headline4?.copyWith(
              color: Colors.black,
              fontSize: AppConsts.commonFontSizeFactor * 16),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AppIcons.ic_back)),
      ),
      body: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  //   height: 45,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.3),
                  //         blurRadius: 4,
                  //         spreadRadius: 4
                  //       )
                  //     ]
                  //   ),
                  //   child: ElevatedButton.icon(
                  //       onPressed: () {
                  //
                  //         Get.toNamed(AppRoutes.routeSearchScreen);
                  //       },
                  //       icon: SvgPicture.asset(AppIcons.ic_search),
                  //       style: ButtonStyle(
                  //           alignment: Alignment.centerLeft,
                  //           backgroundColor:
                  //           MaterialStateProperty.all(Colors.white)),
                  //       label: Text(
                  //         'search'.tr,
                  //         style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  //             color: Colors.black.withOpacity(0.4),
                  //             fontSize: AppConsts.commonFontSizeFactor * 12,
                  //             fontWeight: FontWeight.w300),
                  //       )),
                  // ),

                  Container(
                    margin: const EdgeInsets.all(16),
                    child: CommonSearchField(
                        controller: _shopsController.searchController,
                        onChanged: (value) {},
                        hint: 'search_name'.tr,
                        isShowTrailing: RxBool(false),
                        isShowLeading: RxBool(true),
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(AppIcons.ic_search),
                        )),
                  ),
                  Obx(
                    () => Visibility(
                      visible: _shopsController.shopsNearYou.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8),
                        child: Text(
                          'shop_opening_near_you'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: _shopsController.shopsNearYou.isNotEmpty,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 4, bottom: 16),
                          shrinkWrap: true,
                          itemCount: _shopsController.shopsNearYou.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 200),
                          itemBuilder: (context, index) {
                            return CommonShopGridWidget(
                                onTap: (User user) {
                                  Get.toNamed(
                                      AppRoutes.routeProfileDetailScreen,
                                      arguments: {
                                        AppConsts.keyProviderId: user.id,
                                      });
                                },
                                shopOwner:
                                    _shopsController.shopsNearYou[index]);
                          }),
                    ),
                  ),

                  Obx(
                    () => Visibility(
                      visible: _shopsController.shopsTopRated.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8),
                        child: Text(
                          'top_rated_shops'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                  Obx(
                    () => Visibility(
                      visible: _shopsController.shopsTopRated.isNotEmpty,
                      child: SizedBox(
                        height: 222,
                        child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 7.0,
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 4, bottom: 16),
                            shrinkWrap: true,
                            itemCount: _shopsController.shopsTopRated.length,
                            itemBuilder: (context, index) {
                              return CommonShopGridWidget(
                                  onTap: (User user) {
                                    Get.toNamed(
                                        AppRoutes.routeProfileDetailScreen,
                                        arguments: {
                                          AppConsts.keyProviderId: user.id,
                                        });
                                  },
                                  shopOwner:
                                      _shopsController.shopsTopRated[index]);
                              return SizedBox();
                            }),
                      ),
                    ),
                  ),

                  Obx(
                    () => Visibility(
                      visible: _shopsController.shopsSuggestedForYou.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8),
                        child: Text(
                          'suggested_for_you'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: _shopsController.shopsSuggestedForYou.isNotEmpty,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 4, bottom: 16),
                          shrinkWrap: true,
                          itemCount:
                              _shopsController.shopsSuggestedForYou.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 200),
                          itemBuilder: (context, index) {
                            return CommonShopGridWidget(
                              onTap: (User user) {
                                Get.toNamed(AppRoutes.routeProfileDetailScreen,
                                    arguments: {
                                      AppConsts.keyProviderId: user.id,
                                    });
                              },
                              shopOwner:
                                  _shopsController.shopsSuggestedForYou[index],
                            );
                            return SizedBox();
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(() => Visibility(
                visible: _shopsController.isLoading.value,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
