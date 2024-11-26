import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/controller/search_location/search_location_controller.dart';
import '../../../config/app_colors.dart';
import '../../../consts/app_consts.dart';
import '../../widgets/common/common_search_field.dart';
import '../../widgets/common/search_address_cell.dart';

class SearchLocationScreen extends StatelessWidget {
  final _searchLocationController = Get.put(SearchLocationController());

  SearchLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(68.0),
        child: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 5,
          shadowColor: Colors.grey.shade50,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 24.0),
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              AppIcons.ic_back,
              height: 16,
            ),
          ),
          leadingWidth: 39,
          automaticallyImplyLeading: false,
          titleSpacing: 20,
          title: CommonSearchField(
            isShowLeading: RxBool(true),
            leading: Padding(
              padding: const EdgeInsets.only(left: 10, right: 15),
              child: SvgPicture.asset(
                AppIcons.ic_searchGrey,
              ),
            ),
            controller: _searchLocationController.searchTextController,
            onChanged: _searchLocationController.searchKeyword,
            isShowTrailing: _searchLocationController.isShowTrailing,
            trailing: IconButton(
                onPressed: () {
                  _searchLocationController.clearSearchField();
                },
                icon: const Icon(Icons.cancel)),
            hint: 'what_is_your_address'.tr,
          ),
        ),
      ),
      body: Column(children: [
        Obx(
          () => _searchLocationController.isEmptyList.value
              ? ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        _searchLocationController.selectCurrentLocation();
                      },
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(AppIcons.ic_navigation),
                      ),
                      title: Text(
                        'your_current_location'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontSize: AppConsts.commonFontSizeFactor * 15,
                                color: Colors.black.withOpacity(0.3)),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Obx(
                          () => Text(
                            _searchLocationController.currentCity.value,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 15,
                                    color: Colors.black.withOpacity(0.3)),
                          ),
                        ),
                      ),
                    );
                  })
              : const SizedBox(),
        ),
        Obx(
          () => Expanded(
            child: _searchLocationController.isEmptyList.value ||
                    _searchLocationController.isLoadingPlaces.value
                ? Center(
                    child: Text(
                    _searchLocationController.isLoadingPlaces.value
                        ? 'message_loading_places'.tr
                        : _searchLocationController.isEmptyList.value
                            ? 'message_no_location_found_try_searching'.tr
                            : '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.color_B8,
                        fontSize: AppConsts.commonFontSizeFactor * 15),
                  ))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SearchAddressCell(
                        place: _searchLocationController.places[index],
                        onClick: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _searchLocationController.pickAddress(index);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: _searchLocationController.places.length),
          ),
        )
      ]),
      // Container(
      //   decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(3.0),
      //       boxShadow: [
      //         BoxShadow(
      //             color: Colors.grey.shade400,
      //             spreadRadius: 0.5,
      //             blurRadius: 3.0),
      //       ]),
      //   child:
      //
      //   TextField(
      //     decoration: InputDecoration(
      //       contentPadding: EdgeInsets.zero,
      //       hintText: "What is your address?",
      //       hintStyle: GoogleFonts.ibmPlexSans(
      //           textStyle: TextStyle(
      //               color: const Color(0xFFBDBDBD),
      //               fontSize: AppConsts.commonFontSizeFactor * 13,
      //               fontWeight: FontWeight.w300)),
      //       prefixIcon: Padding(
      //         padding: const EdgeInsets.only(left: 10, right: 15),
      //         child: SvgPicture.asset(
      //           AppIcons.ic_searchGrey,
      //         ),
      //       ),
      //       prefixIconConstraints:
      //           const BoxConstraints(minHeight: 24, minWidth: 40),
      //       border: OutlineInputBorder(
      //           borderSide: BorderSide.none,
      //           borderRadius: BorderRadius.circular(3.0)),
      //     ),
      //     enabled: true,
      //   ),
      // ),
      // ),
      // SearchLocationAppBar(
      //   locationSearchTextController:
      //       _searchLoactionController.searchTextController,
      //   onBackPressed: _searchLoactionController.onBackPressed,
      // ),
    );
  }
}
