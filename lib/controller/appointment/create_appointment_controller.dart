import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/controller/appointment/appointment_detail_controller.dart';
import 'package:stylers_in_customer/controller/calendar/calendar_controller.dart';
import 'package:stylers_in_customer/model/appointment/provider_services_res_model.dart';
import 'package:stylers_in_customer/network/post_requests.dart';

import '../../model/appointment/appointment_detail_res_model.dart';
import '../../model/appointment/booking_free_time_slots_res_model.dart';
import '../../model/appointment/provider_sub_services_res_model.dart';
import '../../model/appointment/remind_me_time.dart';
import '../../network/get_requests.dart';
import '../../utils/helpers.dart';
import '../../utils/preference_manager.dart';

class CreateAppointmentController extends GetxController {
  late final TextEditingController titleController;
  late final TextEditingController noteController;
  Completer<GoogleMapController> mapControllerCompleter = Completer();

  RxBool isLoading = false.obs;
  RxBool isAppointmentDetailLoading = false.obs;
  RxBool isTimeSlotsAvailable = true.obs;
  RxBool isServiceSelected = true.obs;
  RxBool isSubServiceSelected = true.obs;
  RxBool isTimeSlotSelected = true.obs;
  RxBool isLocationAdded = true.obs;

  var selectedService = Rx<ProviderService?>(null);
  var selectedSubService = Rx<ProviderSubService?>(null);
  var selectedTimeSlot = Rx<BookingFreeTimeSlot?>(null);

  LatLng selectedLocation = const LatLng(0.0, 0.0);
  RxString streetAddressLine1 = ''.obs;
  RxString streetAddressLine2 = ''.obs;
  RxString customerName = ''.obs;
  String postalCode = '';
  String city = '';

  int? mAppointmentId;
  AppointmentDetail? mAppointmentDetail;

  int? mProviderId;

  RxString mProviderRole = ''.obs;
  String mProviderProfileImage = '';
  String mProviderName = '';
  RxList<ProviderService> services = <ProviderService>[].obs;
  RxList<ProviderSubService> subServices = <ProviderSubService>[].obs;
  RxList<BookingFreeTimeSlot> freeTimeSlots = <BookingFreeTimeSlot>[].obs;

  String? previousRoute;

  var isEditAppointment = false.obs;

  // var services = <String>['Shaving', 'Scrubbing', 'Haircut'];
  var remindTimes = <RemindMeTime>[
    RemindMeTime(displayString: '10 Minutes Before', minBefore: 10),
    RemindMeTime(displayString: '30 Minutes Before', minBefore: 30),
    RemindMeTime(displayString: '1 Hour Before', minBefore: 60),
  ];

  var selectedCalendarDate = DateTime.now().obs;
  var selectedRemindTime = Rx<RemindMeTime?>(null);
  var isRemind = false.obs;
  var isAddLocation = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  onInit() {
    selectedRemindTime.value = remindTimes[0];
    initializeTextEditingControllers();
    getArgumentsData();
    getPrefData();
    getFreeTimeSlots();

    super.onInit();
  }

  @override
  onClose() {
    titleController.dispose();
    noteController.dispose();

    super.onClose();
  }

  void initializeTextEditingControllers() {
    titleController = TextEditingController();
    noteController = TextEditingController();
  }

  void getPrefData() {
    if (PreferenceManager.getPref(PreferenceManager.prefUserFirstName) !=
            null &&
        PreferenceManager.getPref(PreferenceManager.prefUserLastName) != null) {
      customerName.value =
          '${(PreferenceManager.getPref(PreferenceManager.prefUserFirstName) as String?)!} ${(PreferenceManager.getPref(PreferenceManager.prefUserLastName) as String?)!}';
    }
  }

  void getArgumentsData() {
    Map? data = Get.arguments;
    if (data != null && data.isNotEmpty) {
      isEditAppointment.value = data.containsKey(AppConsts.keyIsEditAppointment)
          ? data[AppConsts.keyIsEditAppointment]
          : false;
      if (data.containsKey(AppConsts.keyEditAppointmentFrom)) {
        print('previous route = ${data[AppConsts.keyEditAppointmentFrom]}');
        previousRoute = data[AppConsts.keyEditAppointmentFrom];
      } else {
        previousRoute = Get.previousRoute;
      }
      if (data.containsKey(AppConsts.keyProviderId)) {
        print('stylist id = ${data[AppConsts.keyProviderId]}');
        mProviderId = data[AppConsts.keyProviderId];
      }
      if (data.containsKey(AppConsts.keyProviderRole)) {
        mProviderRole.value = data[AppConsts.keyProviderRole];
      }
      if (data.containsKey(AppConsts.keyProviderProfileImage)) {
        mProviderProfileImage = data[AppConsts.keyProviderProfileImage];
      }
      if (data.containsKey(AppConsts.keyProviderName)) {
        mProviderName = data[AppConsts.keyProviderName];
      }
      if (data.containsKey(AppConsts.keyAppointmentId)) {
        mAppointmentId = data[AppConsts.keyAppointmentId];
      }
    }

    getAppointmentDetails();
    fetchServices();
  }

  void getAppointmentDetails() async {
    if (isEditAppointment.value) {
      if (previousRoute == AppRoutes.routeAppointmentDetail) {
        final appointmentDetailController =
            Get.find<AppointmentDetailController>();
        mAppointmentDetail = appointmentDetailController.mAppointmentDetail;
      } else {
        if (mAppointmentId != null) {
          isAppointmentDetailLoading.value = true;
          var response =
              await GetRequests.getAppointmentDetail(mAppointmentId!);
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
    }
    setAppointmentData();
  }

  void setAppointmentData() {
    // if (mAppointmentDetail!=null) {
    //   if (mAppointmentDetail!.timeslot != null) {
    //     timeSlot.value = Helpers.convertToTimeSlotFormat(
    //         mAppointmentDetail!.timeslot!.startTime,
    //         mAppointmentDetail!.timeslot!.endTime);
    //   }
    //   if (mAppointmentDetail!.remindMe == 1) {
    //     for (var element in remindTimes) {
    //       if (element.minBefore == mAppointmentDetail!.remindMeTime) {
    //         remindMeTime.value = element.displayString;
    //       }
    //     }
    //   }
    //   if (mAppointmentDetail!.latitude != null &&
    //       mAppointmentDetail!.longitude != null) {
    //     selectedLocation.value = LatLng(
    //         mAppointmentDetail!.latitude!, mAppointmentDetail!.longitude!);
    //   }
    //   appointmentDate.value = mAppointmentDetail!.date;
    //   serviceName.value = mAppointmentDetail!.serviceName ?? '';
    //   subServiceName.value = mAppointmentDetail!.subServiceName ?? '';
    //   totalPrice.value = mAppointmentDetail!.serviceRate ?? '';
    //   appointmentNote.value = mAppointmentDetail!.note ?? '';
    //   providerRole.value = mAppointmentDetail!.bookedUserRole ?? '';
    //   stylistProfileImage.value = mAppointmentDetail!.bookedUserAvatar ?? '';
    //   stylistName.value = mAppointmentDetail!.bookedUserName ?? '';
    // }
  }

  void fetchServices() async {
    if (mProviderId != null) {
      isLoading.value = true;
      var response = await GetRequests.getProviderServices(mProviderId!);
      isLoading.value = false;
      if (response != null) {
        if (response.success) {
          services.value = response.data!;
          if (response.data == null || response.data!.isEmpty) {
            Get.snackbar('error'.tr, 'no_services_found'.tr);
          }
        }
      } else {
        Get.snackbar('error'.tr, 'message_server_error'.tr);
      }
    }
  }

  void fetchSubServices() async {
    Map<String, dynamic> requestData = {
      'service_id': selectedService.value!.id,
    };
    isLoading.value = true;
    var response =
        await PostRequests.getProviderSubServices(requestData, mProviderId!);
    isLoading.value = false;
    if (response != null) {
      if (response.success) {
        subServices.value = response.data!;
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error');
    }
  }

  void onChangeService(var newService) {
    selectedService.value = newService as ProviderService;
    selectedSubService.value = null;
    subServices.value = [];
    fetchSubServices();
  }

  void onChangeSubService(var newSubService) {
    selectedSubService.value = newSubService as ProviderSubService;
  }

  void onChangeRemindTime(var newRemindTime) {
    selectedRemindTime.value = newRemindTime as RemindMeTime;
    // selectedRemindTime.refresh();
  }

  void validateData() {
    if (formKey.currentState!.validate()) {
      if (selectedService.value == null) {
        isServiceSelected.value = false;
      } else {
        isServiceSelected.value = true;
      }
      if (selectedSubService.value == null) {
        isSubServiceSelected.value = false;
      } else {
        isSubServiceSelected.value = true;
      }
      if (selectedService.value == null) {
        isServiceSelected.value = false;
      } else {
        isServiceSelected.value = true;
      }
      if (selectedTimeSlot.value == null) {
        isTimeSlotSelected.value = false;
      } else {
        isTimeSlotSelected.value = true;
      }
      if (mProviderRole.value == 'stylist' &&
          selectedLocation == const LatLng(0.0, 0.0) &&
          (streetAddressLine1.value.isEmpty ||
              streetAddressLine2.value.isEmpty)) {
        isLocationAdded.value = false;
      } else {
        isLocationAdded.value = true;
      }

      if (isServiceSelected.value &&
          isSubServiceSelected.value &&
          isTimeSlotSelected.value &&
          ((mProviderRole.value == 'stylist' && isLocationAdded.value) ||
              mProviderRole.value != 'stylist')) {
        Get.toNamed(AppRoutes.routeAppointmentDetail);
      }
    }
  }

  void onTapRefundYes() {
    Get.toNamed(AppRoutes.routeRefundConfirmation,
        arguments: {AppConsts.keyEditAppointmentFrom: previousRoute});
  }

  void getFreeTimeSlots() async {
    if (mProviderId != null) {
      Map<String, dynamic> requestData = {
        'date': DateFormat("dd-MM-yyyy").format(selectedCalendarDate.value),
      };
      isLoading.value = true;
      var result =
          await PostRequests.getBookingFreeTimeSlots(requestData, mProviderId!);
      isLoading.value = false;
      if (result != null) {
        if (result.success) {
          freeTimeSlots.value = result.data ?? [];
          isTimeSlotsAvailable.value = freeTimeSlots.isNotEmpty;
        } else {
          Get.snackbar('error'.tr, result.message);
        }
      } else {
        Get.snackbar('error'.tr, 'internet_connection_message'.tr);
      }
    }
    debugPrint('Provider ID is null');
  }

  void moveMapCameraToSelectedLocation() async {
    GoogleMapController controller = await mapControllerCompleter.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: selectedLocation,
        tilt: AppConsts.mapCameraTilt,
        zoom: AppConsts.mapCameraZoom)));
  }

  Future<void> createAppointment() async {
    Map<String, dynamic> requestData = {
      'service_id': selectedService.value!.id,
      'sub_service_id': selectedSubService.value!.id,
      'time_slot_id': selectedTimeSlot.value!.id,
      'booked_user_id': mProviderId,
      'remind_me': isRemind.value ? 1 : 0,
      'date': DateFormat("dd-MM-yyyy").format(selectedCalendarDate.value)
    };
    requestData.addIf(noteController.text.toString().trim().isNotEmpty, 'note',
        noteController.text.toString().trim());
    requestData.addIf(
        isRemind.value, 'remind_me_time', selectedRemindTime.value!.minBefore);
    requestData.addAllIf(isLocationAdded.value, {
      'longitude': selectedLocation.longitude,
      'latitude': selectedLocation.latitude,
      'address1': streetAddressLine1.value,
      'address2': streetAddressLine2.value,
      'zip': postalCode
    });
    Helpers.printLog(
        screenName: "Appointment_Request", message: json.encode(requestData));
    isLoading.value = true;
    var result = await PostRequests.createAppointment(requestData);
    isLoading.value = false;
    if (result != null) {
      if (result.success) {
        final calendarController = Get.find<CalendarController>();
        calendarController.getCalendarAppointments();
        Get.until((route) => route.settings.name == AppRoutes.routeDashboard);
        Get.snackbar('appointment_booked'.tr, 'appointment_booked_message'.tr);
      } else {
        Get.snackbar('error'.tr, result.message);
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
  }
}
