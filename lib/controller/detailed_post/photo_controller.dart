import 'package:get/get.dart';

import '../../consts/app_consts.dart';

class PhotoController extends GetxController {
  RxString photo = ''.obs;

  @override
  void onInit() {
    initializePhoto();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initializePhoto() {
    Map<String, dynamic> data = Get.arguments;
    if (data.containsKey(AppConsts.keyMedia)) {
      photo.value = data[AppConsts.keyMedia];
    }
  }
}
