import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/controller/appointment/appointment_detail_controller.dart';

import '../../../consts/app_images.dart';
import '../../dialogs/common/common_dialog.dart';
import '../../widgets/common/common_button.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final _appointmentDetailController = Get.put(AppointmentDetailController());

  AppointmentDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        appBar: AppBar(
          title: Text(
            'appointment_details'.tr,
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
          () => _appointmentDetailController.isAppointmentDetailLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                )
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 6.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(
                                      () => Text(
                                        _appointmentDetailController
                                            .serviceName.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                                color: AppColors.kPrimaryColor),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 11.0,
                                    ),
                                    Obx(
                                      () => Text(
                                        _appointmentDetailController
                                                    .appointmentDate.value ==
                                                null
                                            ? ''
                                            : DateFormat("dd MMMM yyyy").format(
                                                _appointmentDetailController
                                                    .appointmentDate.value!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              fontSize: AppConsts
                                                      .commonFontSizeFactor *
                                                  14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 66.0,
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: _appointmentDetailController
                                                .appointmentDate.value !=
                                            null &&
                                        _appointmentDetailController
                                            .appointmentDate.value!
                                            .isAfter(DateTime.now()),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (_appointmentDetailController
                                                    .isFromCreateAppointment
                                                    .value) {
                                                  Get.back();
                                                } else {
                                                  Get.toNamed(
                                                      AppRoutes
                                                          .routeCreateAppointment,
                                                      arguments: {
                                                        AppConsts
                                                                .keyIsEditAppointment:
                                                            true,
                                                      });
                                                }
                                              },
                                              child: Container(
                                                width: 31.0,
                                                height: 31.0,
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                      AppIcons.ic_edit),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _appointmentDetailController
                                                    .onTapDelete(context);
                                              },
                                              child: Container(
                                                width: 31.0,
                                                height: 31.0,
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                      AppIcons.ic_delete),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 13.0,
                            ),
                            Text(
                              'service_booked'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 18,
                                  ),
                            ),
                            const SizedBox(
                              height: 9.0,
                            ),
                            Obx(
                              () => Text(
                                _appointmentDetailController
                                    .subServiceName.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: AppColors.color_A7_A1,
                                      fontSize:
                                          AppConsts.commonFontSizeFactor * 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 17.0,
                            ),
                            Text(
                              'payment'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 18,
                                  ),
                            ),
                            Divider(
                              thickness: 1.0,
                              color: Colors.black.withOpacity(0.1),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'name'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              color: Colors.black,
                                              fontSize: AppConsts
                                                      .commonFontSizeFactor *
                                                  12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Obx(
                                        () => Text(
                                          _appointmentDetailController
                                              .customerName.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                  color: AppColors.color_6C,
                                                  fontSize: AppConsts
                                                          .commonFontSizeFactor *
                                                      12),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'slots_booked'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              color: Colors.black,
                                              fontSize: AppConsts
                                                      .commonFontSizeFactor *
                                                  12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        'x1',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                                color: AppColors.color_6C,
                                                fontSize: AppConsts
                                                        .commonFontSizeFactor *
                                                    12),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'total'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              color: Colors.black,
                                              fontSize: AppConsts
                                                      .commonFontSizeFactor *
                                                  12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Obx(
                                        () => Text(
                                          '\$${_appointmentDetailController.totalPrice.value}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: AppConsts
                                                          .commonFontSizeFactor *
                                                      14),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: _appointmentDetailController
                                    .appointmentNote.value.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 28.0,
                                    ),
                                    Text(
                                      'note'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            color: Colors.black,
                                            fontSize:
                                                AppConsts.commonFontSizeFactor *
                                                    18,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      _appointmentDetailController
                                          .appointmentNote.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: AppColors.color_6C,
                                              fontSize: AppConsts
                                                      .commonFontSizeFactor *
                                                  12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 22.0,
                            ),
                            Text(
                              'time'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontSize:
                                        AppConsts.commonFontSizeFactor * 18,
                                  ),
                            ),
                            const SizedBox(
                              height: 11.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 138.0,
                                  height: 22.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11.0),
                                      color: AppColors.kPrimaryColor),
                                  child: Center(
                                      child: Obx(
                                    () => Text(
                                      _appointmentDetailController
                                          .timeSlot.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontSize:
                                                AppConsts.commonFontSizeFactor *
                                                    12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  )),
                                ),
                                const SizedBox(
                                  width: 7.0,
                                ),
                                Obx(
                                  () => Text(
                                    _appointmentDetailController
                                                .appointmentDate.value ==
                                            null
                                        ? ''
                                        : '${DateFormat('EEEE').format(_appointmentDetailController.appointmentDate.value!)}, ${DateFormat("dd MMMM yyyy").format(_appointmentDetailController.appointmentDate.value!)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.black.withOpacity(0.4),
                                          fontSize:
                                              AppConsts.commonFontSizeFactor *
                                                  12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => Visibility(
                                visible: _appointmentDetailController
                                    .remindMeTime.value.isNotEmpty,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 31.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'remind_me'.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                color: Colors.black,
                                                fontSize: AppConsts
                                                        .commonFontSizeFactor *
                                                    18,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        SvgPicture.asset(
                                          'assets/icons/ic_remind_me.svg',
                                          height: 22.0,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 13.0,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 13.0, right: 18.75),
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border: Border.all(
                                              color: AppColors.kPrimaryColor
                                                  .withOpacity(0.28))),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          _appointmentDetailController
                                              .remindMeTime.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                  color: AppColors.color_6C,
                                                  fontSize: AppConsts
                                                          .commonFontSizeFactor *
                                                      12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: _appointmentDetailController
                                        .selectedLocation.value !=
                                    const LatLng(0.0, 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 31.0,
                                    ),
                                    Text(
                                      'location'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            color: Colors.black,
                                            fontSize:
                                                AppConsts.commonFontSizeFactor *
                                                    18,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 11.0,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 128.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3.0)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                        child: AbsorbPointer(
                                          child: GoogleMap(
                                            initialCameraPosition: CameraPosition(
                                                target:
                                                    _appointmentDetailController
                                                        .selectedLocation.value,
                                                tilt: AppConsts.mapCameraTilt,
                                                zoom: AppConsts.mapCameraZoom),
                                            onMapCreated: (GoogleMapController
                                                controller) {
                                              _appointmentDetailController
                                                  .mapControllerCompleter
                                                  .complete(controller);
                                            },
                                            compassEnabled: false,
                                            zoomControlsEnabled: false,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: _appointmentDetailController
                                        .providerRole.value ==
                                    'stylist',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 26.0,
                                    ),
                                    Text(
                                      'stylist'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            color: Colors.black,
                                            fontSize:
                                                AppConsts.commonFontSizeFactor *
                                                    18,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 11.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: const AssetImage(
                                              AppImages.imgUserPlaceholder),
                                          foregroundImage: NetworkImage(
                                              _appointmentDetailController
                                                  .stylistProfileImage.value),
                                          radius: 22,
                                        ),
                                        const SizedBox(
                                          width: 7.0,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _appointmentDetailController
                                                  .stylistName.value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                    color: Colors.black,
                                                    fontSize: AppConsts
                                                            .commonFontSizeFactor *
                                                        12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Text(
                                              'Hair Stylist ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium
                                                  ?.copyWith(
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                      fontSize: AppConsts
                                                              .commonFontSizeFactor *
                                                          12),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 18.0,
                            ),
                            Obx(
                              () => Visibility(
                                visible: _appointmentDetailController
                                    .isFromCreateAppointment.value,
                                child: SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                      40.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CommonButton(
                                            horizontalMargin: 0,
                                            text: 'pay_now',
                                            onClick: () {
                                              _appointmentDetailController
                                                  .createAppointment();
                                            }),
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(2.0),
                                              border: Border.all(
                                                color: AppColors.kPrimaryColor,
                                                width: 1.0,
                                              )),
                                          child: CommonButton(
                                              backgroundColor:
                                                  AppColors.appBackgroundColor,
                                              horizontalMargin: 0,
                                              textColor:
                                                  AppColors.kPrimaryColor,
                                              text: 'reserve',
                                              onClick: () {
                                                CommonDialog.show(
                                                    context: context,
                                                    onCancelPress:
                                                        _appointmentDetailController
                                                            .createAppointment,
                                                    onConfirmPress:
                                                        _appointmentDetailController
                                                            .createAppointment,
                                                    middleText:
                                                        'reserve_dialog_notice'
                                                            .tr,
                                                    cancelText: 'pay_now'.tr,
                                                    confirmText: 'proceed'.tr);
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 17.0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Obx(() => Visibility(
                          visible: _appointmentDetailController.isLoading.value,
                          child: Center(
                              child: Container(
                                  height: 51,
                                  width: 51,
                                  padding: const EdgeInsets.all(8),
                                  child: const CircularProgressIndicator())),
                        ))
                  ],
                ),
        ));
  }
}
