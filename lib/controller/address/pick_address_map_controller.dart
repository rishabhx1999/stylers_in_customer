import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../config/app_routes.dart';
import '../../consts/app_consts.dart';
import '../../utils/permission_handler.dart';
import '../appointment/create_appointment_controller.dart';

class PickAddressMapController extends GetxController {
  bool isFromCreateAppointment = false;

  var currentPosition = const LatLng(30.704649, 76.717873).obs;

  Completer<GoogleMapController> mapControllerCompleter = Completer();

  RxString currentAddress = "enter_your_address".obs;
  RxString addressLine1 = ''.obs;
  RxString addressLine2 = "".obs;
  RxString city = "".obs;
  RxString zipcode = "".obs;

  @override
  void onInit() {
    checkIfFromCreateAppointment();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void checkIfFromCreateAppointment() {
    var previousRoute = Get.previousRoute;
    isFromCreateAppointment = previousRoute == AppRoutes.routeCreateAppointment;
    getArgumentsData();
  }

  void getArgumentsData() {
    if (isFromCreateAppointment) {
      Map? data = Get.arguments;
      if (data != null) {
        if (data.containsKey(AppConsts.keyLocation)) {
          currentPosition.value = data[AppConsts.keyLocation];
        }
        if (data.containsKey(AppConsts.keyStreetAddressLine1)) {
          addressLine1.value = data[AppConsts.keyStreetAddressLine1];
        }
        if (data.containsKey(AppConsts.keyStreetAddressLine2)) {
          addressLine2.value = data[AppConsts.keyStreetAddressLine2];
        }
      }
    }

    if (currentPosition.value == const LatLng(0.0, 0.0)) {
      getCurrentLocation();
    } else {
      moveCameraToCurrentPosition();
    }
  }

  void getCurrentLocation() async {
    bool isHavingLocationPermission =
        await PermissionHandler.requestLocationPermission();

    if (isHavingLocationPermission) {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (isServiceEnabled) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        currentPosition.value = LatLng(position.latitude, position.longitude);
        moveCameraToCurrentPosition();
      }
    }
  }

  void getAddress() async {
    List<Placemark> newPlace = await placemarkFromCoordinates(
        currentPosition.value.latitude, currentPosition.value.longitude);

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

    currentAddress.value = processAddressString(placeMark);

    city.value = getCity(placeMark);
    zipcode.value = placeMark.postalCode ?? '';
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

  String processAddressString(Placemark placemark) {
    StringBuffer address = StringBuffer();

    if (placemark.name != null && placemark.name!.isNotEmpty) {
      address.write(placemark.name);
      address.write(",");
    }
    if (placemark.subThoroughfare != null &&
        placemark.subThoroughfare!.isNotEmpty) {
      address.write(placemark.subThoroughfare);
      address.write(",");
    }

    if (placemark.thoroughfare != null && placemark.thoroughfare!.isNotEmpty) {
      address.write(placemark.thoroughfare);
      address.write(",");
    }
    if (placemark.street != null && placemark.street!.isNotEmpty) {
      address.write(placemark.street);
      address.write(",");
    }
    if (placemark.subLocality != null && placemark.subLocality!.isNotEmpty) {
      address.write(placemark.subLocality);
      address.write(",");
    }
    if (placemark.locality != null && placemark.locality!.isNotEmpty) {
      address.write(placemark.locality);
      address.write(",");
    }
    if (placemark.subAdministrativeArea != null &&
        placemark.locality!.isNotEmpty) {
      address.write(placemark.subAdministrativeArea);
      address.write(",");
    }
    if (placemark.administrativeArea != null &&
        placemark.administrativeArea!.isNotEmpty) {
      address.write(placemark.administrativeArea);
      address.write(",");
    }
    if (placemark.postalCode != null && placemark.postalCode!.isNotEmpty) {
      address.write(placemark.postalCode);
      address.write(",");
    }
    if (placemark.country != null && placemark.country!.isNotEmpty) {
      address.write(placemark.country);
      address.write(",");
    }

    return address.toString().substring(0, address.toString().length - 1);
  }

  void moveCameraToCurrentPosition() async {
    GoogleMapController controller = await mapControllerCompleter.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: currentPosition.value,
        tilt: AppConsts.mapCameraTilt,
        zoom: AppConsts.mapCameraZoom)));
  }

  void validateLocationCoordinates() {
    if (isFromCreateAppointment) {
      final createAppointmentController =
          Get.find<CreateAppointmentController>();
      createAppointmentController.selectedLocation = currentPosition.value;
      createAppointmentController.moveMapCameraToSelectedLocation();
    }
    Get.toNamed(AppRoutes.routeAdditionalAddressDetailScreen);
  }
}
