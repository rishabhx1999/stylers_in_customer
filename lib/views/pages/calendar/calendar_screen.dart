import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_images.dart';
import 'package:stylers_in_customer/views/pages/calendar/components/single_day_appointments_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/controller/calendar/calendar_controller.dart';

import '../../widgets/common/common_search_field.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({Key? key}) : super(key: key);

  final _calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(206.0),
            child: AppBar(
              systemOverlayStyle:
                  Theme.of(context).appBarTheme.systemOverlayStyle,
              backgroundColor: Colors.white,
              leading: const SizedBox(
                width: 8,
              ),
              leadingWidth: 24,
              title: Row(
                children: [
                  if (_calendarController.isLoggedIn.value)
                    Obx(
                      () => CircleAvatar(
                        backgroundImage:
                            const AssetImage(AppImages.imgUserPlaceholder),
                        foregroundImage: NetworkImage(
                            _calendarController.profileImage.value),
                        radius: 18,
                      ),
                    ),
                  const SizedBox(
                    width: 8,
                  ),
                  Obx(
                    () => Text(
                      DateFormat('MMM')
                          .format(_calendarController.selectedDay.value),
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontSize: AppConsts.commonFontSizeFactor * 16,
                            color: Colors.black,
                          ),
                    ),
                  ),
                ],
              ),
              titleSpacing: 0,
              elevation: 6.0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(133.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // const SizedBox(
                    //   height: 16.0,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CommonSearchField(
                        controller: _calendarController.searchController,
                        onChanged: (value) {},
                        hint: 'search'.tr,
                        isShowTrailing: RxBool(false),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child:
                          // CalendarWidget()
                          Obx(
                        () => TableCalendar(
                          currentDay: DateTime.now(),
                          calendarStyle: CalendarStyle(
                              isTodayHighlighted: false,
                              todayDecoration: BoxDecoration(
                                color: AppColors.kPrimaryColor.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                  color: AppColors.kPrimaryColor,
                                  shape: BoxShape.circle)),
                          firstDay: _calendarController.calendarFirstDay,
                          lastDay: _calendarController.calendarLastDay,
                          focusedDay: _calendarController.selectedDay.value,
                          headerVisible: false,
                          daysOfWeekVisible: true,
                          startingDayOfWeek: StartingDayOfWeek.sunday,
                          calendarFormat: CalendarFormat.week,
                          selectedDayPredicate: (day) {
                            debugPrint("SELECTED_DAY_PREDICATE =  $day");
                            return isSameDay(
                                _calendarController.selectedDay.value, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            debugPrint(
                                'ON_DAY_SELECTED  ===== SELECTED_DAY = $selectedDay, FOCUSED_DAY = $focusedDay');
                            _calendarController.selectedDay.value = selectedDay;
                            _calendarController.selectedDay.refresh();
                          },
                          onPageChanged: (day) {
                            debugPrint("PAGE_CHANGED Start = $day");
                            _calendarController.selectedDay.value =
                                _calendarController
                                    .calculateFirstAccessibleDate(day);
                            _calendarController.selectedDay.refresh();
                            _calendarController.getCalendarAppointments();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14.0,
                    )
                  ],
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 28.0,
                    ),
                    Obx(
                      () => ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SingleDayAppointmentsWidget(
                            onEdit: () {
                              _calendarController.searchController.clear();
                            },
                            firstDate: _calendarController
                                .calculateFirstAccessibleDate(
                                    _calendarController.selectedDay.value)
                                .obs,
                            index: index,
                            singleDayAppointments:
                                _calendarController.calendarAppointments[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 21.0,
                          );
                        },
                        itemCount:
                            _calendarController.calculateShowDaysLength(),
                      ),
                    ),
                    const SizedBox(
                      height: 13.0,
                    )
                  ],
                ),
              ),
              Obx(() => Visibility(
                    visible: _calendarController.isLoading.value,
                    child: Center(
                        child: Container(
                            height: 51,
                            width: 51,
                            padding: const EdgeInsets.all(8),
                            child: const CircularProgressIndicator())),
                  ))
            ],
          )),
    );
  }
}
