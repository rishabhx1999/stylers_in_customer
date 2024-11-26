import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/controller/appointment/create_appointment_controller.dart';

import '../../consts/app_consts.dart';
import '../../model/appointment/appointment_detail_res_model.dart';
import '../../model/appointment/remind_me_time.dart';
import '../../network/get_requests.dart';
import '../../network/post_requests.dart';
import '../../utils/helpers.dart';
import '../../utils/preference_manager.dart';
import '../../views/dialogs/common/common_dialog.dart';
import '../calendar/calendar_controller.dart';

class AppointmentDetailController extends GetxController {
  Completer<GoogleMapController> mapControllerCompleter = Completer();
  RxBool isLoading = false.obs;
  RxBool isAppointmentDetailLoading = false.obs;

  int? mAppointmentId;
  AppointmentDetail? mAppointmentDetail;
  RxString serviceName = ''.obs;
  var appointmentDate = Rx<DateTime?>(null);
  RxString subServiceName = ''.obs;
  RxString customerName = ''.obs;
  RxString totalPrice = ''.obs;
  RxString appointmentNote = ''.obs;
  RxString timeSlot = ''.obs;
  RxString remindMeTime = ''.obs;
  Rx<LatLng> selectedLocation = const LatLng(0.0, 0.0).obs;
  RxString stylistName = ''.obs;
  RxString stylistProfileImage = ''.obs;
  RxString providerRole = ''.obs;

  var remindTimes = <RemindMeTime>[
    RemindMeTime(displayString: '10 Minutes Before', minBefore: 10),
    RemindMeTime(displayString: '30 Minutes Before', minBefore: 30),
    RemindMeTime(displayString: '1 Hour Before', minBefore: 60),
  ];

  RxBool isFromDashboard = true.obs;
  RxBool isFromCreateAppointment = false.obs;

  @override
  void onInit() {
    checkPreviousRoute();
    getPrefData();
    super.onInit();
  }

  void getPrefData() {
    if (PreferenceManager.getPref(PreferenceManager.prefUserFirstName) !=
            null &&
        PreferenceManager.getPref(PreferenceManager.prefUserLastName) != null) {
      customerName.value =
          '${(PreferenceManager.getPref(PreferenceManager.prefUserFirstName) as String?)!} ${(PreferenceManager.getPref(PreferenceManager.prefUserLastName) as String?)!}';
    }
  }

  void checkPreviousRoute() {
    var previousRoute = Get.previousRoute;
    isFromDashboard.value = previousRoute == AppRoutes.routeDashboard;
    isFromCreateAppointment.value =
        previousRoute == AppRoutes.routeCreateAppointment;
    getAppointmentDetail();
    getAppointmentId();
  }

  void getAppointmentDetail() {
    if (isFromCreateAppointment.value) {
      final createAppointmentController =
          Get.find<CreateAppointmentController>();
      serviceName.value =
          createAppointmentController.selectedService.value!.name ?? '';
      appointmentDate.value =
          createAppointmentController.selectedCalendarDate.value;
      subServiceName.value =
          createAppointmentController.selectedSubService.value!.name ?? '';
      customerName.value = createAppointmentController.customerName.value;
      totalPrice.value =
          createAppointmentController.selectedSubService.value!.serviceRate ??
              '';
      appointmentNote.value =
          createAppointmentController.noteController.text.toString().trim();
      timeSlot.value = Helpers.convertToTimeSlotFormat(
          createAppointmentController.selectedTimeSlot.value!.startTime,
          createAppointmentController.selectedTimeSlot.value!.endTime);
      remindMeTime.value = createAppointmentController.isRemind.value
          ? createAppointmentController.selectedRemindTime.value!.displayString
          : '';
      selectedLocation.value = createAppointmentController.selectedLocation;
      stylistName.value = createAppointmentController.mProviderName;
      stylistProfileImage.value =
          createAppointmentController.mProviderProfileImage;
      providerRole.value = createAppointmentController.mProviderRole.value;
    }
  }

  void getAppointmentId() {
    if (isFromDashboard.value) {
      Map? data = Get.arguments;
      if (data != null && data.isNotEmpty) {
        if (data.containsKey(AppConsts.keyAppointmentId)) {
          mAppointmentId = data[AppConsts.keyAppointmentId];
        }
      }
    }
    fetchAppointmentDetails();
  }

  void fetchAppointmentDetails() async {
    if (mAppointmentId != null) {
      isAppointmentDetailLoading.value = true;
      var response = await GetRequests.getAppointmentDetail(mAppointmentId!);
      isAppointmentDetailLoading.value = false;
      if (response != null) {
        if (response.success) {
          mAppointmentDetail = response.data;
          setAppointmentData();
        } else {
          Get.snackbar('error'.tr, response.message);
        }
      } else {
        Get.snackbar('error'.tr, 'internet_connection_message'.tr);
      }
    }
  }

  void setAppointmentData() {
    if (mAppointmentDetail != null) {
      if (mAppointmentDetail!.timeslot != null) {
        timeSlot.value = Helpers.convertToTimeSlotFormat(
            mAppointmentDetail!.timeslot!.startTime,
            mAppointmentDetail!.timeslot!.endTime);
      }
      if (mAppointmentDetail!.remindMe == 1) {
        for (var element in remindTimes) {
          if (element.minBefore == mAppointmentDetail!.remindMeTime) {
            remindMeTime.value = element.displayString;
          }
        }
      }
      if (mAppointmentDetail!.latitude != null &&
          mAppointmentDetail!.longitude != null) {
        selectedLocation.value = LatLng(
            mAppointmentDetail!.latitude!, mAppointmentDetail!.longitude!);
      }
      appointmentDate.value = mAppointmentDetail!.date;
      serviceName.value = mAppointmentDetail!.serviceName ?? '';
      subServiceName.value = mAppointmentDetail!.subServiceName ?? '';
      totalPrice.value = mAppointmentDetail!.serviceRate ?? '';
      appointmentNote.value = mAppointmentDetail!.note ?? '';
      providerRole.value = mAppointmentDetail!.bookedUserRole ?? '';
      stylistProfileImage.value = mAppointmentDetail!.bookedUserAvatar ?? '';
      stylistName.value = mAppointmentDetail!.bookedUserName ?? '';
    }
  }

  void createAppointment() async {
    if (isFromCreateAppointment.value) {
      final createAppointmentController =
          Get.find<CreateAppointmentController>();
      isLoading.value = true;
      await createAppointmentController.createAppointment();
      isLoading.value = false;
    }
  }

  void onTapDelete(BuildContext context) {
    String previousRoute = Get.previousRoute;
    print('detail previous route = $previousRoute');
    CommonDialog.show(
        context: context,
        onCancelPress: () {
          if (isFromDashboard.value) {
            cancelAppointment();
          }
          Get.until((route) => route.settings.name == AppRoutes.routeDashboard);
        },
        middleText: 'cancel_appointment_notice'.tr,
        cancelText: 'yes'.tr,
        confirmText: 'no'.tr);
  }

  void cancelAppointment() async {
    if (mAppointmentId != null) {
      Map<String, dynamic> requestData = {
        'appointment_id': mAppointmentId,
        'is_customer': 1
      };
      isLoading.value = true;
      var result = await PostRequests.cancelAppointment(requestData);
      isLoading.value = false;
      if (result != null) {
        if (result.success) {
          final calendarController = Get.find<CalendarController>();
          calendarController.getCalendarAppointments();
          Get.snackbar('success'.tr, 'appointment_cancelled_message'.tr);
        } else {
          Get.snackbar('error'.tr, result.message);
        }
      } else {
        Get.snackbar('error'.tr, 'internet_connection_message'.tr);
      }
    }
  }
}
