// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:get/get.dart';
//
// class CalendarWidget extends StatefulWidget {
//   Function(DateTime) onTableCalendarChange;
//
//   CalendarWidget({Key? key,required this.onTableCalendarChange}) : super(key: key);
//
//   @override
//   State<CalendarWidget> createState() => _CalendarWidgetState();
// }
//
// class _CalendarWidgetState extends State<CalendarWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() =>
//         TableCalendar(
//           // currentDay: DateTime.now(),
//           calendarStyle: CalendarStyle(),
//           firstDay: DateTime.utc(2020, 10, 20),
//           lastDay: DateTime.utc(2040, 10, 20),
//           focusedDay: DateTime.now(),
//           headerVisible: false,
//           daysOfWeekVisible: true,
//           startingDayOfWeek: StartingDayOfWeek.sunday,
//           calendarFormat: CalendarFormat.week,
//           onPageChanged
//           :,
//         ));
//   }
// }
