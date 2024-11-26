import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/controller/dashboard/dashboard_controller.dart';
import 'package:stylers_in_customer/views/pages/dashboard/components/bottom_navigation_bar.dart';
import 'package:stylers_in_customer/views/pages/dashboard/components/drawer_widget.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  final _dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _dashboardController.goToPreviousBottomBarItem,
      child: Scaffold(
          drawer: Drawer(
            width: 250,
            child: DrawerWidget(),
          ),
          body: Obx(() => _dashboardController
              .tabs![_dashboardController.bottomBarIndex.value].screen),
          bottomNavigationBar: Obx(
            () => CustomBottomNavigationBar(
              context: context,
              selectedIndex: _dashboardController.bottomBarIndex.value,
              onChange: _dashboardController.changeBottomNavBarItem,
              tabs: _dashboardController.tabs ?? [],
            ),
          )),
    );
  }
}
