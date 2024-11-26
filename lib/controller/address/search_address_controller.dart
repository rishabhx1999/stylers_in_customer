import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:stylers_in_customer/controller/address/pick_address_map_controller.dart';

import '../../consts/app_consts.dart';

class SearchAddressController extends GetxController {
  late TextEditingController searchEditingController;

  RxString searchKeyword = ''.obs;
  RxBool isShowTrailing = false.obs;
  RxBool isEmptyList = true.obs;
  RxBool isLoadingPlaces = false.obs;

  late GooglePlace googlePlace;
  var places = <AutocompletePrediction>[].obs;

  Worker? searchPlacesWorker;

  @override
  void onInit() {
    super.onInit();

    initEditingController();
    searchEditingController.addListener(() {
      isShowTrailing.value =
          searchEditingController.text.toString().trim().isNotEmpty;
    });

    googlePlace = GooglePlace(AppConsts.googleApiKey);
    initSearchPlacesWorkker();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    disposeEditingController();
    searchPlacesWorker?.dispose();
    super.onClose();
  }

  void initSearchPlacesWorkker() {
    searchPlacesWorker = debounce(searchKeyword, (callback) => searchPlaces());
  }

  void initEditingController() {
    searchEditingController = TextEditingController();
  }

  void disposeEditingController() {
    searchEditingController.dispose();
  }

  void clearSearchField() {
    searchEditingController.clear();
    places.clear();
    isEmptyList.value = places.isEmpty;
    isLoadingPlaces.value = false;
  }

  void searchPlaces() async {
    debugPrint('Loading');
    isLoadingPlaces.value = true;
    if (searchKeyword.value.isNotEmpty) {
      var result = await googlePlace.autocomplete.get(searchKeyword.value);
      places.assignAll(result?.predictions ?? []);
    } else {
      places.clear();
    }

    isLoadingPlaces.value = false;
    isEmptyList.value = places.isEmpty;
  }

  void pickAddress(int index) async {
    var address = places[index].description ?? "";
    if (address.isNotEmpty) {
      List<geocoding.Location> result =
          await geocoding.locationFromAddress(address);

      if (result.isNotEmpty) {
        final pickAddressMapController = Get.find<PickAddressMapController>();
        pickAddressMapController.currentPosition.value =
            LatLng(result.first.latitude, result.first.longitude);
        pickAddressMapController.moveCameraToCurrentPosition();
        Get.back();
      }
    }
  }
}
