import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';

class RefundConfirmationController extends GetxController {
  String? okRedirectRoute;

  @override
  void onInit() {
    print('refund oninit working');
    Map? data = Get.arguments;
    if (data != null) {
      if (data.containsKey(AppConsts.keyEditAppointmentFrom)) {
        print('refund ok redirect = ${data[AppConsts.keyEditAppointmentFrom]}');
        okRedirectRoute = data[AppConsts.keyEditAppointmentFrom];
      }
    }
    super.onInit();
  }
}
