import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/model/details/profile_detail_res_model.dart';

class ServiceDetailWidget extends StatelessWidget {
  var isShowServiceDetail = false.obs;
  Service service;

  ServiceDetailWidget({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.color_C4.withOpacity(0.1),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                service.serviceName ?? '',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: Colors.black),
              ),
              IconButton(
                style:
                    IconButton.styleFrom(splashFactory: NoSplash.splashFactory),
                onPressed: () {
                  isShowServiceDetail.value = !isShowServiceDetail.value;
                },
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(right: 10.87),
                icon: SvgPicture.asset(
                  AppIcons.ic_arrow_down,
                  color: Colors.black,
                ),
              )
            ],
          ),
          Obx(() => isShowServiceDetail.value
              ? const SizedBox(
                  height: 8.0,
                )
              : const SizedBox()),
          Obx(() => Visibility(
                visible: isShowServiceDetail.value,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 5.0,
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          service.subServices![index].subServiceName ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  color: Colors.black,
                                  fontSize:
                                      AppConsts.commonFontSizeFactor * 12),
                        ),
                        Text(
                          '${service.subServices![index].rate ?? '0'} \$',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  color: Colors.black,
                                  fontSize:
                                      AppConsts.commonFontSizeFactor * 12),
                        )
                      ],
                    );
                  },
                  itemCount: service.subServices == null ||
                          service.subServices!.isEmpty
                      ? 0
                      : service.subServices!.length,
                ),
              ))
        ],
      ),
    );
  }
}
