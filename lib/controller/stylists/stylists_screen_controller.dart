

import 'package:get/get.dart';
import 'package:stylers_in_customer/model/login/login_res_model.dart';
import 'package:stylers_in_customer/network/get_requests.dart';

class StylistsScreenController extends GetxController{

  RxBool isLoading = false.obs;
  var stylists = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
   getStylists();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }



  getStylists(){
    List<User>? data = Get.arguments;
    if(data !=null){
      stylists.assignAll(data);
    }else{
      fetchStylistsServer();
    }

  }






  fetchStylistsServer() async{
    isLoading.value = true;

    var result = await GetRequests.getStylists();

    if(result !=null){

      if(result.success){
        stylists.assignAll(result.stylists??[]);
      }else{
        Get.snackbar('error'.tr, result.message);
      }


    }else{
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
    isLoading.value = false;

  }
}