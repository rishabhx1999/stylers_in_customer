import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  late final TextEditingController cardNoController;
  late final TextEditingController nameController;
  late final TextEditingController expiryController;
  late final TextEditingController cvcController;

  @override
  void onInit() {
    cardNoController = TextEditingController();
    nameController = TextEditingController();
    expiryController = TextEditingController();
    cvcController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    cardNoController.dispose();
    nameController.dispose();
    expiryController.dispose();
    cvcController.dispose();

    super.onClose();
  }
}
