import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/controller/appointment/create_appointment_controller.dart';
import 'package:stylers_in_customer/model/appointment/provider_services_res_model.dart';
import 'package:stylers_in_customer/model/appointment/provider_sub_services_res_model.dart';
import 'package:stylers_in_customer/utils/helpers.dart';

import '../../../config/app_routes.dart';
import '../../../model/appointment/remind_me_time.dart';
import '../../dialogs/common/common_dialog.dart';
import '../../widgets/common/common_button.dart';
import '../../widgets/common/common_dropdown_widget.dart';
import '../../widgets/common/common_input_field.dart';

class SendAppointmentScreen extends StatelessWidget {
  final _createAppointmentController = Get.put(CreateAppointmentController());

  var noteFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.kPrimaryColor.withOpacity(0.28)));

  SendAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        title: Obx(
          () => Text(
            _createAppointmentController.isEditAppointment.value
                ? 'edit_appointment'.tr
                : 'send_appointment_offer'.tr,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                color: Colors.black,
                fontSize: AppConsts.commonFontSizeFactor * 16),
          ),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 13.0),
                child: Form(
                  key: _createAppointmentController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'service'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      Obx(
                        () => CommonDropdownWidget(
                          dropdownIcon: SvgPicture.asset(AppIcons.ic_dropdown),
                          onChanged:
                              _createAppointmentController.onChangeService,
                          items: _createAppointmentController.services
                              .map((service) =>
                                  DropdownMenuItem<ProviderService>(
                                    value: service,
                                    child: Text(
                                      service.name ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontSize: AppConsts
                                                      .commonFontSizeFactor *
                                                  12),
                                    ),
                                  ))
                              .toList(),
                          value: _createAppointmentController.selectedService,
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: _createAppointmentController
                                  .isServiceSelected.value ==
                              false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                'select_service'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        color: Colors.red,
                                        fontSize:
                                            AppConsts.commonFontSizeFactor * 12,
                                        fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      Text(
                        'sub_service'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      Obx(
                        () => CommonDropdownWidget(
                          dropdownIcon: SvgPicture.asset(AppIcons.ic_dropdown),
                          onChanged:
                              _createAppointmentController.onChangeSubService,
                          items: _createAppointmentController.subServices
                              .map((subService) =>
                                  DropdownMenuItem<ProviderSubService>(
                                    value: subService,
                                    child: Text(
                                      subService.name ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontSize: AppConsts
                                                      .commonFontSizeFactor *
                                                  12),
                                    ),
                                  ))
                              .toList(),
                          value:
                              _createAppointmentController.selectedSubService,
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: _createAppointmentController
                                  .isSubServiceSelected.value ==
                              false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                'select_sub_service'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        color: Colors.red,
                                        fontSize:
                                            AppConsts.commonFontSizeFactor * 12,
                                        fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      Text(
                        'add_note'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      CommonInputField(
                        marginRight: 0,
                        marginBottom: 0,
                        marginTop: 0,
                        marginLeft: 0,
                        controller: _createAppointmentController.noteController,
                        hint: 'write something here..',
                        maxLines: 6,
                        inputHorizontalPadding: 13.0,
                        inputVerticalPadding: 10.0,
                        inputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      Text(
                        'select_date'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          DateTime? pickedDate = await showDatePicker(
                            initialDate: _createAppointmentController
                                .selectedCalendarDate.value,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 5),
                            context: context,
                          );
                          if (pickedDate != null) {
                            _createAppointmentController
                                .isTimeSlotsAvailable.value = true;
                            _createAppointmentController
                                .selectedCalendarDate.value = pickedDate;
                            _createAppointmentController
                                .selectedTimeSlot.value = null;
                            _createAppointmentController.getFreeTimeSlots();
                          } else {
                            print("Time is not selected");
                          }
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 13.0, right: 14.31),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                  color: AppColors.kPrimaryColor
                                      .withOpacity(0.28))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Text(
                                  DateFormat("dd MMMM yyyy").format(
                                      _createAppointmentController
                                          .selectedCalendarDate.value),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(color: Colors.black),
                                ),
                              ),
                              SvgPicture.asset(AppIcons.ic_appointment_calendar)
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: _createAppointmentController
                                  .isTimeSlotsAvailable.value ==
                              false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                'no_free_slots_message'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        color: Colors.red,
                                        fontSize:
                                            AppConsts.commonFontSizeFactor * 12,
                                        fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: _createAppointmentController
                              .freeTimeSlots.isNotEmpty,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 14.0,
                              ),
                              Text(
                                'select_timeslot'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(color: Colors.black),
                              ),
                              const SizedBox(
                                height: 7.0,
                              ),
                              Wrap(
                                children:
                                    _createAppointmentController.freeTimeSlots
                                        .map((timeSlot) => Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    _createAppointmentController
                                                        .selectedTimeSlot
                                                        .value = timeSlot;
                                                  },
                                                  child: Obx(
                                                    () => Column(
                                                      children: [
                                                        Container(
                                                          width: 138.0,
                                                          height: 22.0,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .kPrimaryColor,
                                                                  width: 1.0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          11.0),
                                                              color: _createAppointmentController
                                                                          .selectedTimeSlot
                                                                          .value ==
                                                                      timeSlot
                                                                  ? AppColors
                                                                      .kPrimaryColor
                                                                  : Colors
                                                                      .transparent),
                                                          child: Center(
                                                              child: Text(
                                                            Helpers.convertToTimeSlotFormat(
                                                                timeSlot
                                                                    .startTime,
                                                                timeSlot
                                                                    .endTime),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6
                                                                ?.copyWith(
                                                                    color: _createAppointmentController
                                                                                .selectedTimeSlot.value ==
                                                                            timeSlot
                                                                        ? Colors
                                                                            .white
                                                                        : AppColors
                                                                            .kPrimaryColor),
                                                          )),
                                                        ),
                                                        const SizedBox(
                                                          height: 6.0,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 2.0,
                                                )
                                              ],
                                            ))
                                        .toList(),
                              ),
                              Obx(
                                () => Visibility(
                                  visible: _createAppointmentController
                                          .isTimeSlotSelected.value ==
                                      false,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        'select_timeslot'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                color: Colors.red,
                                                fontSize: AppConsts
                                                        .commonFontSizeFactor *
                                                    12,
                                                fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _createAppointmentController.isRemind.value =
                                  !_createAppointmentController.isRemind.value;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              width: 18.0,
                              height: 18.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.0)),
                              child: Obx(() =>
                                  _createAppointmentController.isRemind.value
                                      ? Container(
                                          color: AppColors.kPrimaryColor,
                                          width: double.infinity,
                                          height: double.infinity,
                                        )
                                      : const SizedBox()),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'remind_me'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          SvgPicture.asset('assets/icons/ic_remind_me.svg'),
                        ],
                      ),
                      Obx(
                        () => _createAppointmentController.isRemind.value
                            ? const SizedBox(
                                height: 6.0,
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                      ),
                      Obx(() => _createAppointmentController.isRemind.value
                          ? CommonDropdownWidget(
                              dropdownIcon: SvgPicture.asset(
                                  AppIcons.ic_arrow_down,
                                  color: AppColors.color_1D.withOpacity(0.52)),
                              value: _createAppointmentController
                                  .selectedRemindTime,
                              onChanged: _createAppointmentController
                                  .onChangeRemindTime,
                              items: _createAppointmentController.remindTimes
                                  .map((remindTime) =>
                                      DropdownMenuItem<RemindMeTime>(
                                        value: remindTime,
                                        child: Text(
                                          remindTime.displayString,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              ?.copyWith(
                                                  color: AppColors.color_6C,
                                                  fontSize: AppConsts
                                                          .commonFontSizeFactor *
                                                      12),
                                        ),
                                      ))
                                  .toList())
                          : const SizedBox()),
                      Obx(
                        () => Visibility(
                          visible: _createAppointmentController
                                  .mProviderRole.value ==
                              'stylist',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 21.0,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _createAppointmentController
                                                .isAddLocation.value =
                                            !_createAppointmentController
                                                .isAddLocation.value;
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(2.0),
                                        width: 18.0,
                                        height: 18.0,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.0)),
                                        child: Obx(() =>
                                            _createAppointmentController
                                                    .isAddLocation.value
                                                ? Container(
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                  )
                                                : const SizedBox()),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'add_location_required'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ]),
                              Obx(() => _createAppointmentController
                                      .isAddLocation.value
                                  ? const SizedBox(
                                      height: 10.0,
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    )),
                              Obx(
                                () => Visibility(
                                  visible: _createAppointmentController
                                      .isAddLocation.value,
                                  child: Stack(
                                    children: [
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
                                                      _createAppointmentController
                                                          .selectedLocation,
                                                  tilt: AppConsts.mapCameraTilt,
                                                  zoom:
                                                      AppConsts.mapCameraZoom),
                                              onMapCreated: (GoogleMapController
                                                  controller) {
                                                _createAppointmentController
                                                    .mapControllerCompleter
                                                    .complete(controller);
                                              },
                                              compassEnabled: false,
                                              zoomControlsEnabled: false,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          left: 8.0,
                                          top: 8.0,
                                          child: Container(
                                            constraints: const BoxConstraints(
                                                minWidth: 128.0,
                                                minHeight: 32.0,
                                                maxWidth: 160.0,
                                                maxHeight: 48.0),
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      blurRadius: 8.0,
                                                      spreadRadius: 4.0),
                                                ],
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                  AppIcons.ic_location_pin,
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                ),
                                                const SizedBox(
                                                  width: 4.0,
                                                ),
                                                Expanded(
                                                  child: Obx(() => GestureDetector(
                                                        onTap: () {
                                                          Get.toNamed(
                                                              AppRoutes
                                                                  .routePickAddressMapScreen,
                                                              arguments: {
                                                                AppConsts
                                                                        .keyStreetAddressLine1:
                                                                    _createAppointmentController
                                                                        .streetAddressLine1
                                                                        .value,
                                                                AppConsts
                                                                        .keyStreetAddressLine2:
                                                                    _createAppointmentController
                                                                        .streetAddressLine2
                                                                        .value,
                                                                AppConsts
                                                                        .keyLocation:
                                                                    _createAppointmentController
                                                                        .selectedLocation
                                                              });
                                                        },
                                                        behavior: HitTestBehavior
                                                            .opaque,
                                                        child: Text(
                                                            _createAppointmentController
                                                                        .streetAddressLine1
                                                                        .value
                                                                        .isEmpty &&
                                                                    _createAppointmentController
                                                                        .streetAddressLine2
                                                                        .value
                                                                        .isEmpty
                                                                ? 'tap_to_add_address'
                                                                    .tr
                                                                : '${_createAppointmentController.streetAddressLine1.value}, ${_createAppointmentController.streetAddressLine2.value}',
                                                            overflow: TextOverflow
                                                                .clip,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5
                                                                ?.copyWith(
                                                                    color: AppColors
                                                                        .color_6C,
                                                                    fontSize: AppConsts
                                                                            .commonFontSizeFactor *
                                                                        12.0)),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Obx(
                                () => Visibility(
                                  visible: _createAppointmentController
                                          .isLocationAdded.value ==
                                      false,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        'add_location'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                color: Colors.red,
                                                fontSize: AppConsts
                                                        .commonFontSizeFactor *
                                                    12,
                                                fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 23.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: _createAppointmentController
                                  .selectedSubService.value !=
                              null,
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1.0,
                                color: Colors.black.withOpacity(0.1),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 9.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'name'.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              ?.copyWith(
                                                  color:
                                                      AppColors.kPrimaryColor),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          _createAppointmentController
                                              .customerName.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              ?.copyWith(
                                                  color: Colors.black,
                                                  fontSize: AppConsts
                                                          .commonFontSizeFactor *
                                                      12),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'slots_booked'.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              ?.copyWith(
                                                  color:
                                                      AppColors.kPrimaryColor),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          'x1',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              ?.copyWith(
                                                  color: Colors.black,
                                                  fontSize: AppConsts
                                                          .commonFontSizeFactor *
                                                      12),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'total'.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              ?.copyWith(
                                                  color:
                                                      AppColors.kPrimaryColor),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          '\$${_createAppointmentController.selectedSubService.value == null ? '' : _createAppointmentController.selectedSubService.value!.serviceRate ?? ''}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: AppConsts
                                                          .commonFontSizeFactor *
                                                      14),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 37.0,
                      ),
                      Obx(
                        () => _createAppointmentController
                                .isEditAppointment.value
                            ? SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width - 40.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CommonButton(
                                          horizontalMargin: 0,
                                          text: 'save_changes',
                                          onClick: () {}),
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
                                            textColor: AppColors.kPrimaryColor,
                                            text: 'refund',
                                            onClick: () {
                                              CommonDialog.show(
                                                  context: context,
                                                  onCancelPress:
                                                      _createAppointmentController
                                                          .onTapRefundYes,
                                                  middleText:
                                                      'refund_dialog_notice'.tr,
                                                  cancelText: 'yes'.tr,
                                                  confirmText: 'no'.tr);
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : CommonButton(
                                horizontalMargin: 0,
                                text: 'next',
                                onClick: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _createAppointmentController.validateData();
                                }),
                      ),
                      const SizedBox(
                        height: 29.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(() => Visibility(
                visible: _createAppointmentController.isLoading.value,
                child: Center(
                    child: Container(
                        height: 51,
                        width: 51,
                        padding: const EdgeInsets.all(8),
                        child: const CircularProgressIndicator())),
              ))
        ],
      ),
    );
  }
}
