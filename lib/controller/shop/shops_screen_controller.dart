import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/network/get_requests.dart';
import 'package:stylers_in_customer/network/post_requests.dart';

import '../../model/login/login_res_model.dart';

class ShopsScreenController extends GetxController {
  late TextEditingController searchController;
  Worker? searchTextChangeListenerWorker;

  var shopsNearYou = <User>[].obs;
  var shopsTopRated = <User>[].obs;
  var shopsSuggestedForYou = <User>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    setupSearchTextChangeListener();
    fetchShops();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchTextChangeListenerWorker?.dispose();
    super.onClose();
  }

  void fetchShops({String? searchText}) async {
    Map<String, dynamic>? requestBody;
    if (searchText != null && searchText != '') {
      requestBody = {'search': searchText};
    }
    isLoading.value = true;
    var result = await PostRequests.getShops(requestBody);

    if (result != null) {
      if (result.success) {
        shopsNearYou.assignAll(result.shopsData?.shopsOpeningNearYou ?? []);
        shopsTopRated.assignAll(result.shopsData?.topRatedShops ?? []);
        shopsSuggestedForYou.assignAll(result.shopsData?.suggestedForYou ?? []);
      } else {
        Get.snackbar('error'.tr, result.message);
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }

    isLoading.value = false;
  }

  void setupSearchTextChangeListener() {
    RxString searchText = ''.obs;
    searchTextChangeListenerWorker = debounce(
        searchText, (callback) => fetchShops(searchText: searchText.value));

    searchController.addListener(() {
      searchText.value = searchController.text.toString().trim();
    });
  }
}
