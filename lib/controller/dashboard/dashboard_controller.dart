import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/model/dashboard/home_bottom_nav_model.dart';
import 'package:stylers_in_customer/views/pages/calendar/calendar_screen.dart';
import 'package:stylers_in_customer/views/pages/home/home_screen.dart';
import 'package:stylers_in_customer/views/pages/news_feed/news_feed_screen.dart';
import 'package:stylers_in_customer/views/pages/stylists/stylists_screen.dart';
import 'package:stylers_in_customer/views/pages/notifications/notifications_screen.dart';
import 'package:stylers_in_customer/views/pages/inbox/inbox_screen.dart';

class DashboardController extends GetxController {
  var bottomBarIndex = 0.obs;

  late final List<HomeBottomNavModel>? tabs;

  List<int> previousBottomBarTabs = [0];

  @override
  void onInit() {
    super.onInit();
    populateTabs();
  }

  populateTabs() {
    tabs = [
      HomeBottomNavModel(
          title: 'home', icon: AppIcons.ic_home, screen: HomeScreen()),
      HomeBottomNavModel(
          title: 'news_feed',
          icon: AppIcons.ic_newsFeed,
          screen: NewsFeedScreen()),
      HomeBottomNavModel(
          title: 'calendar',
          icon: AppIcons.ic_calendar,
          screen: CalendarScreen()),
      HomeBottomNavModel(
          title: 'inbox', icon: AppIcons.ic_inbox, screen: InboxScreen()),
      HomeBottomNavModel(
          title: 'notifs',
          icon: AppIcons.ic_notifications,
          screen: NotificationsScreen()),
    ];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabs = null;
    super.onClose();
  }

  void changeBottomNavBarItem(int index) {
    // Get.toNamed(AppRoutes.routeDashboard);
    bottomBarIndex.value = index;
    if (previousBottomBarTabs.contains(index)) {
      previousBottomBarTabs = [0, index];
    } else {
      previousBottomBarTabs.add(index);
    }
    // bottomBarIndex.refresh();
  }

  Future<bool> goToPreviousBottomBarItem() async {
    if (previousBottomBarTabs.length == 1) {
      return Future.delayed(const Duration(milliseconds: 1), () => true);
    }
    for (var previousTab in previousBottomBarTabs) {
      print('previous tab = $previousTab ${previousBottomBarTabs.last}');
    }
    bottomBarIndex.value =
        previousBottomBarTabs[previousBottomBarTabs.length - 2];
    previousBottomBarTabs.removeLast();
    return Future.delayed(const Duration(seconds: 1), () => false);
  }
}
