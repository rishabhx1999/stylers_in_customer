import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/controller/search/search_controller.dart' as search;
import 'package:stylers_in_customer/utils/enums/search_cell_type.dart';
import '../../../model/search/search_res_model.dart';
import '../../widgets/common/chip_widget.dart';
import '../../widgets/common/common_search_field.dart';
import '../../widgets/common/common_service_widget.dart';
import '../../widgets/common/common_shop_list_widget.dart';
import '../../widgets/common/stylist_widget_search.dart';

class SearchScreen extends StatelessWidget {
  final _searchController = Get.put(search.SearchController());

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            systemOverlayStyle:
                Theme.of(context).appBarTheme.systemOverlayStyle,
            elevation: 5,
            shadowColor: Colors.grey.shade50,
            automaticallyImplyLeading: false,
            titleSpacing: 20,
            leadingWidth: 0,
            title: CommonSearchField(
              controller: _searchController.searchTextController,
              onChanged: _searchController.onSearchTextChange,
              hint: 'search'.tr,
              isShowTrailing: _searchController.isShowTrailing,
              isShowLeading: RxBool(true),
              leading: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.back();
                  },
                  constraints: const BoxConstraints(),
                  icon: SvgPicture.asset(
                    AppIcons.ic_back,
                    width: 14,
                  )),
              trailing: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: _searchController.onTapClose,
                  icon: SvgPicture.asset(AppIcons.ic_clear)),
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(26.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 26.0,
                      child: Row(children: [
                        const SizedBox(
                          width: 20.0,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ChipWidget(
                                  title: _searchController.chipOptions[index],
                                  currentIndex: index,
                                  selectedIndex:
                                      _searchController.selectedChipIndex,
                                  onTap: _searchController.onChipTap);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 4.0,
                              );
                            },
                            itemCount: _searchController.chipOptions.length),
                      ]),
                    ),
                    const SizedBox(
                      height: 10.0,
                    )
                  ],
                )),
          ),
        ),
        body: Obx(
          () => ListView.builder(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
              shrinkWrap: true,
              itemCount: _searchController.searchItemsFilter.length,
              itemBuilder: (context, index) {
                var cellType =
                    _searchController.searchItemsFilter[index].cellType;

                if (cellType == SearchCellType.header) {
                  return headerWidget(context,
                      _searchController.searchItemsFilter[index].header ?? '');
                } else if (cellType == SearchCellType.stylistsList) {
                  List<dynamic>? items =
                      _searchController.searchItemsFilter[index].list;

                  return items!.isEmpty
                      ? const SizedBox(
                          height: 200,
                          child: Center(child: Text('No Data')),
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return StylistWidgetSearch(
                              user: items[index],
                              onTab: (Provider user) {
                                _searchController.searchTextController.clear();
                                FocusManager.instance.primaryFocus?.unfocus();
                                Get.toNamed(AppRoutes.routeProfileDetailScreen,
                                    arguments: {
                                      AppConsts.keyProviderId: user.id,
                                    });
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8,
                            );
                          },
                          itemCount: items?.length ?? 0);
                } else if (cellType == SearchCellType.shopList) {
                  List<Provider>? items = _searchController
                      .searchItemsFilter[index].list as List<Provider>?;
                  return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CommonShopListWidget(
                            shopOwner: items![index],
                            onTap: (Provider shop) {
                              _searchController.searchTextController.clear();
                              FocusManager.instance.primaryFocus?.unfocus();
                              Get.toNamed(AppRoutes.routeProfileDetailScreen,
                                  arguments: {
                                    AppConsts.keyProviderId: shop.id,
                                  });
                            });
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemCount: items?.length ?? 0);
                } else if (cellType == SearchCellType.serviceGrid) {
                  List<Service>? items = _searchController
                      .searchItemsFilter[index].list as List<Service>?;
                  return GridView.builder(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: /*_searchController.isLoading.value
                          ? 4
                          :*/
                          items?.length ?? 0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 16.0,
                              mainAxisExtent: 87),
                      itemBuilder: (context, index) {
                        return /*_searchController.isLoading.value
                            ? const CommonServiceWidgetShimmer()
                            :*/
                            CommonServiceWidget(
                                icon: items![index].image!,
                                title: items![index].name!,
                                onServiceTap: () {
                                  _searchController.searchTextController
                                      .clear();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                });
                      });

                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CommonServiceWidget(
                            icon: AppIcons.ic_service,
                            title: 'Haircut',
                            onServiceTap: () {});
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemCount: items?.length ?? 0);
                } else {
                  return const SizedBox();
                }
              }),
        ));
  }

  Widget headerWidget(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: AppConsts.commonFontSizeFactor * 18, color: Colors.black),
      ),
    );
  }
}
