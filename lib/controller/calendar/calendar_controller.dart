import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/calendar/calendar_appointments_res_model.dart';
import '../../network/post_requests.dart';
import '../../utils/preference_manager.dart';

class CalendarController extends GetxController {
  late final TextEditingController searchController;
  RxBool isLoading = false.obs;

  RxString profileImage = ''.obs;
  RxList<List<CalendarAppointment>> calendarAppointments =
      <List<CalendarAppointment>>[].obs;
  RxInt showDaysCount = 0.obs;
  RxBool isLoggedIn = false.obs;

  Rx<DateTime> selectedDay = DateTime.now().obs;
  DateTime calendarFirstDay = DateTime(2022);
  DateTime calendarLastDay = DateTime.now().add(const Duration(days: 90));

  PageController? pageController;

  // var firstDate =
  //     DateTime.now().obs;

  @override
  void onInit() {
    searchController = TextEditingController();
    getPrefData();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getPrefData() {
    isLoggedIn.value =
        (PreferenceManager.getPref(PreferenceManager.prefIsLogin) as bool?) ??
            false;
    profileImage.value =
        (PreferenceManager.getPref(PreferenceManager.prefUserImage)
                as String?) ??
            '';
    getCalendarAppointments();
  }

  void getCalendarAppointments() async {
    if (isLoggedIn.value) {
      DateTime requestDate = calculateFirstAccessibleDate(selectedDay.value);
      Map<String, dynamic> requestData = {
        'date': DateFormat("dd-MM-yyyy").format(requestDate),
      };
      isLoading.value = true;
      var result = await PostRequests.getCalendarAppointments(requestData);
      isLoading.value = false;
      if (result != null) {
        if (result.success) {
          calendarAppointments.value = result.data ?? [];
          calendarAppointments.refresh();
          // updateDaysCount();
        } else {
          Get.snackbar('error'.tr, result.message);
        }
      } else {
        Get.snackbar('error'.tr, 'internet_connection_message'.tr);
      }
    }
  }

  // void updateDaysCount() {
  //   showDaysCount.value =
  //       (7 - selectedDay.value.weekday) > calendarAppointments.length
  //           ? calendarAppointments.length
  //           : (7 - selectedDay.value.weekday);
  //   if (selectedDay.value.weekday == 7) {
  //     showDaysCount.value =
  //         7 > calendarAppointments.length ? calendarAppointments.length : 7;
  //   }
  //   debugPrint('SELECTED_WEEKDAY = ${selectedDay.value.weekday}');
  //   debugPrint('SHOW_DAYS_COUNT = ${showDaysCount.value}');
  //   debugPrint('RESPONSE_DAYS_COUNT = ${showDaysCount.value}');
  // }

  DateTime calculateFirstAccessibleDate(DateTime date) {
    var firstAccessibleDate = date;
    if (date.weekday == 7) {
      firstAccessibleDate = date;
    } else {
      // If date goes before first date :-
      var showingSundayDate = date.subtract(Duration(days: date.weekday));
      if (showingSundayDate.isBefore(calendarFirstDay)) {
        firstAccessibleDate = calendarFirstDay;
      } else {
        firstAccessibleDate = showingSundayDate;
      }
    }
    return firstAccessibleDate;
  }

  DateTime calculateLastAccessibleDate(DateTime date) {
    var lastAccessibleDate = date;
    if (date.weekday == 6) {
      lastAccessibleDate = date;
    } else {
      var showingSaturdayDate = date;
      if (date.weekday == 7) {
        showingSaturdayDate = date.add(const Duration(days: 6));
      } else {
        var noOfDaysToSaturday = 6 - date.weekday;
        showingSaturdayDate = date.add(Duration(days: noOfDaysToSaturday));
      }

      if (showingSaturdayDate.isAfter(calendarLastDay)) {
        lastAccessibleDate = calendarLastDay;
      } else {
        lastAccessibleDate = showingSaturdayDate;
      }
    }
    return lastAccessibleDate;
  }

  int calculateShowDaysLength() {
    var firstShowingAccessibleDate =
        calculateFirstAccessibleDate(selectedDay.value);
    var lastShowingAccessibleDate =
        calculateLastAccessibleDate(selectedDay.value);
    var noOfShowingAccessibleDays =
        daysBetween(firstShowingAccessibleDate, lastShowingAccessibleDate) + 1;

    if (noOfShowingAccessibleDays > calendarAppointments.length) {
      debugPrint('SHOW_DAYS_LENGTH = ${calendarAppointments.length}');
      return calendarAppointments.length;
    } else {
      debugPrint('SHOW_DAYS_LENGTH = $noOfShowingAccessibleDays');
      return noOfShowingAccessibleDays;
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
