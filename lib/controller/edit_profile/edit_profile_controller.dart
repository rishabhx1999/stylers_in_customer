import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/controller/customer_profile/customer_profile_controller.dart';

import '../../model/profile/edit_profile_res_model.dart';
import '../../network/post_requests.dart';
import '../../utils/permission_handler.dart';
import '../../utils/preference_manager.dart';
import '../calendar/calendar_controller.dart';
import '../home/home_controller.dart';
import '../inbox/inbox_controller.dart';
import '../news_feed/news_feed_controller.dart';

class EditProfileController extends GetxController {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  // late final TextEditingController addressController;
  // late final TextEditingController cityController;
  // late final TextEditingController provinceController;
  // late final TextEditingController postalCodeController;
  final formKey = GlobalKey<FormState>();
  bool isFromProfileScreen = false;
  RxBool isLoading = false.obs;

  ImagePicker? _picker;
  var selectedImage = Rx<XFile?>(null);

  RxString profileImage = "".obs;
  // RxString mPostalCode = "".obs;

  // Worker? postalCodeChangeWorker;

  @override
  void onInit() {
    initializeTextEditingControllers();
    initializeImagePicker();
    checkPreviousRoute();
    // setUpPostalCodeChangeWorker();
    getPrefData();

    super.onInit();
  }

  @override
  void onClose() {
    // postalCodeChangeWorker?.dispose();
    super.onClose();
  }

  void checkPreviousRoute() {
    isFromProfileScreen = Get.previousRoute == AppRoutes.routeCustomerProfile;
  }

  void initializeImagePicker() {
    _picker = ImagePicker();
  }

  void initializeTextEditingControllers() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    // addressController = TextEditingController();
    // cityController = TextEditingController();
    // provinceController = TextEditingController();
    // postalCodeController = TextEditingController();
  }

  getPrefData() {
    firstNameController.text =
        (PreferenceManager.getPref(PreferenceManager.prefUserFirstName)
                as String?) ??
            '';
    lastNameController.text =
        (PreferenceManager.getPref(PreferenceManager.prefUserLastName)
                as String?) ??
            '';
    profileImage.value =
        (PreferenceManager.getPref(PreferenceManager.prefUserImage)
                as String?) ??
            '';
    emailController.text =
        (PreferenceManager.getPref(PreferenceManager.prefUserEmail)
                as String?) ??
            '';
    // addressController.text =
    //     (PreferenceManager.getPref(PreferenceManager.prefUserAddress)
    //             as String?) ??
    //         '';
    // cityController.text =
    //     (PreferenceManager.getPref(PreferenceManager.prefUserCity)
    //             as String?) ??
    //         '';
    // provinceController.text =
    //     (PreferenceManager.getPref(PreferenceManager.prefUserProvince)
    //             as String?) ??
    //         '';
    // if ((PreferenceManager.getPref(PreferenceManager.prefUserPostalCode)
    //         as int?) !=
    //     null) {
    //   postalCodeController.text =
    //       (PreferenceManager.getPref(PreferenceManager.prefUserPostalCode)
    //               as int?)
    //           .toString();
    // }
  }

  // void setUpPostalCodeChangeWorker() {
  //   postalCodeChangeWorker = debounce(mPostalCode, (callback) async {
  //     if (mPostalCode.value.length >= 5) {
  //       setupLocationDataFromPostalCode(mPostalCode.value.toString());
  //     }
  //   });
  // }

  // void setupLocationDataFromPostalCode(String postalCode) async {
  //   try {
  //     List<Location> myLocation = await locationFromAddress(postalCode);
  //     if (myLocation.isNotEmpty) {
  //       List<Placemark> placemark = await placemarkFromCoordinates(
  //           myLocation[0].latitude, myLocation[0].longitude);
  //
  //       String? province;
  //       String? city;
  //
  //       city = placemark[0].subAdministrativeArea;
  //       if (city == null || city == "") {
  //         city = placemark[0].locality;
  //       }
  //       province = placemark[0].administrativeArea;
  //
  //       cityController.text = city ?? "";
  //       provinceController.text = province ?? "";
  //     }
  //   } catch (e) {}
  // }

  void saveChanges() async {
    http.MultipartFile? uploadMedia;
    if (selectedImage.value != null) {
      uploadMedia =
          await http.MultipartFile.fromPath('image', selectedImage.value!.path);
    }
    Map<String, String> requestBody = {
      'email': emailController.text,
      'first_name': firstNameController.text.trim(),
      'last_name': lastNameController.text.trim(),
      // 'address': addressController.text.trim(),
      // 'city': cityController.text.trim(),
      // 'state': provinceController.text.trim(),
      // 'zip_code': postalCodeController.text.trim(),
    };

    isLoading.value = true;
    var response = await PostRequests.editProfileData(uploadMedia, requestBody);
    isLoading.value = false;
    if (response != null) {
      if (response.success) {
        updatePrefData(response.data);
      } else {
        Get.snackbar('error', response.message);
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
  }

  void updatePrefData(EditProfileResponse? data) {
    if (data != null) {
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserFirstName, data.firstName);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserLastName, data.lastName);
      PreferenceManager.save2Pref(PreferenceManager.prefUserImage, data.avatar);
      // PreferenceManager.save2Pref(
      //     PreferenceManager.prefUserAddress, data.address1);
      // PreferenceManager.save2Pref(PreferenceManager.prefUserCity, data.city);
      // PreferenceManager.save2Pref(
      //     PreferenceManager.prefUserProvince, data.state);
      // if (data.zipCode != null) {
      //   PreferenceManager.save2Pref(
      //       PreferenceManager.prefUserPostalCode, int.parse(data.zipCode));
      // }

      updatePreviousPageData(data);
    }
  }

  void updatePreviousPageData(EditProfileResponse data) {
    final homeController = Get.find<HomeController>();
    homeController.personName.value = data.name ?? '';
    homeController.personImage.value = data.avatar ?? '';

    final newsFeedController = Get.find<NewsFeedController>();
    newsFeedController.personImage.value = data.avatar ?? '';

    final calendarController = Get.find<CalendarController>();
    calendarController.profileImage.value = data.avatar ?? '';

    final inboxController = Get.find<InboxController>();
    inboxController.profileImage.value = data.avatar ?? '';

    if (isFromProfileScreen) {
      final customerProfileController = Get.find<CustomerProfileController>();
      customerProfileController.getProfileDetails();
    }
    //
    // final notificationsController = Get.find<NotificationController>();
    // notificationsController.profileImage.value = data.avatar ?? '';

    if (isFromProfileScreen) {
      Get.back();
    } else {
      Get.back();
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    }
  }

  void picImage(ImageSource source) async {
    var isHavingPermissions = await PermissionHandler.requestCameraPermission();
    if (isHavingPermissions) {
      selectedImage.value = await _picker?.pickImage(source: source);
    }
  }
}
