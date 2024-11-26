import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/controller/address/pick_address_map_controller.dart';

import '../appointment/create_appointment_controller.dart';

class AdditionalAddressDetailController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final pickAddressMapController = Get.find<PickAddressMapController>();

  late TextEditingController addressLine1Controller;
  late TextEditingController addressLine2Controller;
  late TextEditingController cityController;
  late TextEditingController zipcodeController;

  @override
  void onInit() {
    super.onInit();
    initEditingControllers();
    cityController.text = pickAddressMapController.city.value;
    zipcodeController.text = pickAddressMapController.zipcode.value;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    disposeEditingController();
    super.onClose();
  }

  void initEditingControllers() {
    addressLine1Controller = TextEditingController();
    addressLine2Controller = TextEditingController();
    cityController = TextEditingController();
    zipcodeController = TextEditingController();
  }

  void disposeEditingController() {
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    cityController.dispose();
    zipcodeController.dispose();
  }

  void validateAddressData() {
    if (formKey.currentState!.validate()) {
      setAddressData();
    }
  }

  void setAddressData() {
    if (pickAddressMapController.isFromCreateAppointment) {
      final createAppointmentController =
          Get.find<CreateAppointmentController>();
      createAppointmentController.streetAddressLine1.value =
          addressLine1Controller.text.toString().trim();
      createAppointmentController.streetAddressLine2.value =
          addressLine2Controller.text.toString().trim();
      createAppointmentController.postalCode =
          zipcodeController.text.toString().trim();
      createAppointmentController.city = cityController.text.toString().trim();
      Get.until((route) => route.settings.name == AppRoutes.routeCreateAppointment);
    }
  }
}
