import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/utils/helpers.dart';

import '../../../model/calendar/calendar_appointments_res_model.dart';

class CommonAppointmentWidget extends StatelessWidget {
  Widget? actionWidget;
  double? actionWidgetLeft;
  void Function() onTap;
  CalendarAppointment appointmentData;

  CommonAppointmentWidget(
      {Key? key,
      required this.onTap,
      this.actionWidget,
      this.actionWidgetLeft,
      required this.appointmentData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              // width: 235.0,
              height: 82.0,
              padding: const EdgeInsets.only(left: 4.0, top: 4.0, bottom: 4.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 5.0,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(2.5)),
                  ),
                  const SizedBox(
                    width: 9.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        appointmentData.service == null
                            ? ''
                            : appointmentData.service!.name ?? '',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppIcons.ic_person,
                            height: 12.0,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            appointmentData.bookedUser == null
                                ? ''
                                : appointmentData.bookedUser!.name ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 12,
                                  color: Colors.black.withOpacity(0.56),
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppIcons.ic_schedule,
                            height: 12.0,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            appointmentData.timeslot == null
                                ? ''
                                : Helpers.convertToTimeSlotFormat(
                                    appointmentData.timeslot!.startTime,
                                    appointmentData.timeslot!.endTime),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 12,
                                  color: Colors.black.withOpacity(0.56),
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppIcons.ic_location_pin,
                            color: Colors.black,
                            height: 12.0,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            appointmentData.bookedUser == null
                                ? ''
                                : '${appointmentData.bookedUser!.address1}, ${appointmentData.bookedUser!.address2}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontSize: AppConsts.commonFontSizeFactor * 12,
                                  color: Colors.black.withOpacity(0.56),
                                ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: actionWidgetLeft ?? 12.0,
        ),
        actionWidget ??
            const SizedBox(
              width: 100.0,
            ),
        const SizedBox(
          width: 26.0,
        )
      ],
    );
  }
}
