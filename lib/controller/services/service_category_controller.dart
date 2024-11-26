import 'package:get/get.dart';
import 'package:stylers_in_customer/model/services/services_res_model.dart';
import 'package:stylers_in_customer/network/get_requests.dart';

class ServiceCategoryController extends GetxController {
  RxBool isLoading = false.obs;

  var services = <Service>[].obs;

  @override
  void onInit() {
    super.onInit();
    getServices();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getServices() {
    List<Service>? data = Get.arguments;
    if (data != null) {
      services.assignAll(data);
    }
    fetchServicesServer();
  }

  fetchServicesServer() async {
    isLoading.value = true;

    var result = await GetRequests.getServices();

    if (result != null) {
      if (result.success) {
        services.assignAll(result.services ?? []);
      } else {
        Get.snackbar('error'.tr, result.message);
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
    isLoading.value = false;
  }
}
