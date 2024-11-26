import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';

import '../../../config/app_colors.dart';
import '../../../model/calendar/calendar_appointments_res_model.dart';
import '../../widgets/common/common_appointment_widget.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        title: Text(
          'booking_history'.tr,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 21.0,
            ),
            ListView.separated(
                padding: const EdgeInsets.only(left: 20.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CommonAppointmentWidget(
                    onTap: () {},
                    actionWidgetLeft: 74.0,
                    actionWidget: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        IconButton(
                          onPressed: () {},
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            AppIcons.ic_download,
                            height: 20.0,
                          ),
                        )
                      ],
                    ),
                    appointmentData: CalendarAppointment(id: 0),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 12.0,
                  );
                },
                itemCount: 8),
            const SizedBox(
              height: 12.0,
            )
          ],
        ),
      ),
    );
  }
}
