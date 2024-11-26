import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/controller/services/service_category_controller.dart';
import 'package:stylers_in_customer/model/services/services_res_model.dart';
import 'package:stylers_in_customer/views/pages/home/components/service_widget.dart';

import '../../../config/app_routes.dart';
import '../../widgets/common/common_service_widget_shimmer.dart';

class ServiceCategoriesScreen extends StatelessWidget {
  ServiceCategoriesScreen({Key? key}) : super(key: key);
  final _serviceCategoryController = Get.put(ServiceCategoryController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        title: Text(
          'services'.tr,
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
        () => GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            shrinkWrap: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            itemCount: _serviceCategoryController.isLoading.value
                ? 16
                : _serviceCategoryController.services.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 16.0,
                mainAxisExtent: 87),
            itemBuilder: (context, index) {
              return _serviceCategoryController.isLoading.value
                  ? const CommonServiceWidgetShimmer()
                  : ServiceWidget(
                      service: _serviceCategoryController.services[index],
                      onTap: (Service service) {
                        Get.toNamed(AppRoutes.routeSearchScreen, arguments: {
                          AppConsts.keySearchKeyword: service.name,
                        });
                      },
                    );
            }),
      ),
    );
  }
}
