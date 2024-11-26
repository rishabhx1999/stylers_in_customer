import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessagesController extends GetxController {
  late final TextEditingController messageController;

  @override
  void onInit() {
    messageController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
