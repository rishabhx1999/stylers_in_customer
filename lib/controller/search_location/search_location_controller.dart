import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../consts/app_consts.dart';
import '../home/home_controller.dart';
import 'package:google_place/google_place.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class SearchLocationController extends GetxController {
  late final TextEditingController searchTextController;
  final homeController = Get.find<HomeController>();

  var currentCity = "Getting...".obs;
  var currentPosition = const LatLng(30.704649, 76.717873).obs;
  var places = <AutocompletePrediction>[].obs;

  RxBool isEmptyList = true.obs;
  RxBool isShowTrailing = false.obs;
  RxString searchKeyword = ''.obs;
  RxBool isLoadingPlaces = false.obs;

  late GooglePlace googlePlace;

  Worker? searchPlacesWorker;

  void onBackPressed() {
    Get.back();
  }

  @override
  void onInit() {
    searchTextController = TextEditingController();
    searchTextController.addListener(() {
      isShowTrailing.value =
          searchTextController.text.toString().trim().isNotEmpty;
    });
    googlePlace = GooglePlace(AppConsts.googleApiKey);
    initSearchPlacesWorker();

    getCurrentLocation();
    super.onInit();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
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

  void getCurrentLocation() async {
    bool isHavingLocationPermission = await checkForLocationPermission();

    if (isHavingLocationPermission) {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (isServiceEnabled) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        currentPosition.value = LatLng(position.latitude, position.longitude);
        Placemark? placemark = await getAddress(currentPosition.value);
        if (placemark != null) {
          currentCity.value = getCity(placemark);
        }
      }
    }
  }

  String getCity(Placemark placemark) {
    debugPrint("place_subAdmin  ${placemark.subAdministrativeArea}");
    debugPrint("place_locality  ${placemark.locality}");
    debugPrint("place_subLocality  ${placemark.subLocality}");
    if (placemark.subAdministrativeArea != null &&
        placemark.subAdministrativeArea!.isNotEmpty) {
      return placemark.subAdministrativeArea!;
    } else if (placemark.locality != null && placemark.locality!.isNotEmpty) {
      return placemark.locality!;
    } else if (placemark.subLocality != null &&
        placemark.subLocality!.isNotEmpty) {
      return placemark.subLocality!;
    } else {
      return placemark.country ?? '';
    }
  }

  Future<bool> checkForLocationPermission() async {
    if (await Permission.locationWhenInUse.isGranted) {
      return true;
    } else {
      var isGranted = await Permission.locationWhenInUse.request().isGranted;
      if (isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }

  void initSearchPlacesWorker() {
    searchPlacesWorker = debounce(searchKeyword, (callback) => searchPlaces());
  }

  Future<Placemark?> getAddress(LatLng position) async {
    List<Placemark> newPlace =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark placeMark = newPlace[0];
    String? name = placeMark.name;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;

    String? address =
        "Name = $name, Street ${placeMark.street},subThoroughfare ${placeMark.subThoroughfare}, thoroughfare= ${placeMark.thoroughfare} ,subLocality =$subLocality,locality = $locality, administrativeArea=$administrativeArea postalCode=$postalCode, country=$country";
    debugPrint("address====  = $address");

    return placeMark;
  }

  selectCurrentLocation() {
    FocusManager.instance.primaryFocus?.unfocus();

    homeController.selectedLocation.value = currentPosition.value;
    homeController.city.value = currentCity.value;
    Get.back();

    homeController.isLocationProvided.value = true;
    homeController.getHomeData();
  }

  void clearSearchField() {
    searchTextController.clear();
    places.clear();
    isEmptyList.value = places.isEmpty;
    isLoadingPlaces.value = false;
  }

  void pickAddress(int index) async {
    var address = places[index].description ?? "";
    debugPrint('Picked Place = ');
    if (address.isNotEmpty) {
      List<geocoding.Location> result =
          await geocoding.locationFromAddress(address);

      if (result.isNotEmpty) {
        homeController.selectedLocation.value =
            LatLng(result.first.latitude, result.first.longitude);
        Placemark? placemark = await getAddress(
            LatLng(result.first.latitude, result.first.longitude));
        if (placemark != null) {
          homeController.city.value = getCity(placemark);
        }
        Get.back();
        homeController.isLocationProvided.value = true;
        homeController.getHomeData();
      }
    }
  }
}
