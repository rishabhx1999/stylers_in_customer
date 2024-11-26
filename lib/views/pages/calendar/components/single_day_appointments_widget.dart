import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';

import '../../../../model/calendar/calendar_appointments_res_model.dart';
import '../../../widgets/common/common_appointment_widget.dart';
import '../../../widgets/common/common_button.dart';

class SingleDayAppointmentsWidget extends StatelessWidget {
  var firstDate = DateTime.now().obs;
  int index;
  Function onEdit;
  List<CalendarAppointment> singleDayAppointments = <CalendarAppointment>[];

  SingleDayAppointmentsWidget(
      {Key? key,
      required this.firstDate,
      required this.index,
      required this.onEdit,
      required this.singleDayAppointments})
      : super(key: key);

  String currentDay(bool isDayMonth) {
    debugPrint('SHOW_DAYS_INDEX = $index');
    DateTime currentDateTime = firstDate.value.add(Duration(days: index));
    bool isSameMonthYear = currentDateTime.year == DateTime.now().year &&
        currentDateTime.month == DateTime.now().month;

    if (isDayMonth) {
      return DateFormat('dd MMM').format(currentDateTime);
    }

    return isSameMonthYear && currentDateTime.day == DateTime.now().day
        ? 'Today'
        : isSameMonthYear && currentDateTime.day == DateTime.now().day + 1
            ? 'Tomorrow'
            // : isSameMonthYear && currentDateTime.day == DateTime.now().day - 1
            //     ? 'Yesterday'
            : DateFormat('EEEE')
                .format(firstDate.value.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Text(
                  currentDay(true),
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: AppColors.kPrimaryColor,fontSize: AppConsts.commonFontSizeFactor * 18,),
                ),
              ),
              const SizedBox(
                width: 6.0,
              ),
              Obx(
                () => Text(
                  currentDay(false),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black.withOpacity(0.4),
                      fontSize: AppConsts.commonFontSizeFactor * 12,
                    fontWeight: FontWeight.w300,),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6.0,
          ),
          singleDayAppointments.isEmpty
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 38.0,
                      width: MediaQuery.of(context).size.width - 32,
                      padding: const EdgeInsets.only(
                          left: 4.0, top: 4.0, bottom: 4.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2.0)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 5.0,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.color_F3,
                                borderRadius: BorderRadius.circular(2.5)),
                          ),
                          const SizedBox(
                            width: 9.0,
                          ),
                          Text(
                            'no_schedule'.tr,
                            style:
                                Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                  ],
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, appointmentIndex) {
                    return CommonAppointmentWidget(
                      appointmentData: singleDayAppointments[appointmentIndex],
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Get.toNamed(AppRoutes.routeAppointmentDetail,
                            arguments: {
                              AppConsts.keyAppointmentId:
                                  singleDayAppointments[appointmentIndex].id
                            });
                      },
                      actionWidget:
                          singleDayAppointments[appointmentIndex].date == null
                              ? null
                              : singleDayAppointments[appointmentIndex]
                                      .date!
                                      .isBefore(DateTime.now())
                                  ? null
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        SizedBox(
                                          width: 100.0,
                                          height: 30.0,
                                          child: CommonButton(
                                            text: 'edit',
                                            onClick: () {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              // Get.toNamed(
                                              //     AppRoutes.routeCreateAppointment,
                                              //     arguments: {
                                              //       AppConsts.keyIsEditAppointment:
                                              //           true,
                                              //       AppConsts
                                              //               .keyEditAppointmentFrom:
                                              //           AppRoutes.routeDashboard
                                              //     });
                                              onEdit();
                                            },
                                            borderRadius: 2.0,
                                          ),
                                        )
                                      ],
                                    ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 7.0,
                    );
                  },
                  itemCount: singleDayAppointments.length)
        ],
      ),
    );
  }
}
