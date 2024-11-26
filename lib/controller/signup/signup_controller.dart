import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/config/app_colors.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:stylers_in_customer/consts/app_consts.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stylers_in_customer/model/signup/signup_res_model.dart';

import '../../consts/app_formatters.dart';
import '../../network/post_requests.dart';
import '../../utils/enums/user_exist_check_type.dart';
import '../../utils/helpers.dart';
import '../../utils/preference_manager.dart';

class SignupController extends GetxController {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final formKey = GlobalKey<FormState>();
  var selectedCountry = Rx<Country>(Country.parse('US'));

  RxBool isAgreeToTerms = false.obs;
  RxBool isLoading = false.obs;
  RxBool isFromOnboard = false.obs;

  RxBool isShowEmailExistTip = false.obs;
  RxBool isShowUsernameExistTip = false.obs;
  RxBool isShowPhoneExistTip = false.obs;

  RxBool isEmailExist = false.obs;
  RxBool isUsernameExist = false.obs;
  RxBool isPhoneExist = false.obs;

  Worker? emailChangeListenerWorker;
  Worker? usernameChangeListenerWorker;
  Worker? phoneChangeListenerWorker;
  Worker? countryCodeChangeListenerWorker;

  var inputBorderSearchCountryCode = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.kPrimaryColor.withOpacity(0.28)));

  @override
  void onInit() {
    super.onInit();

    initTextEditingControllers();
    setupEmailTextChangeListener();
    setupUsernameChangeListenerWorker();
    setupPhoneChangeListenerWorker();

    Map? data = Get.arguments;
    isFromOnboard.value = data!.containsKey(AppConsts.keySignupFrom)
        ? data[AppConsts.keySignupFrom] == AppRoutes.routeOnBoardingPage
        : false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    disposeTextEditingControllers();
    disposeTextChangeListeners();

    super.onClose();
  }

  initTextEditingControllers() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  disposeTextEditingControllers() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  disposeTextChangeListeners() {
    emailChangeListenerWorker?.dispose();
    usernameChangeListenerWorker?.dispose();
    phoneChangeListenerWorker?.dispose();
    countryCodeChangeListenerWorker?.dispose();
  }

  validatePageData() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate() &&
        !isEmailExist.value &&
        !isUsernameExist.value &&
        !isPhoneExist.value) {
      if (isAgreeToTerms.value) {
        requestOtp(emailController.text.toString().trim());
      } else {
        Get.snackbar('alert'.tr, 'message_accept_terms'.tr);
      }
    }
  }

  void requestOtp(String email) async {
    isLoading.value = true;
    var response = await PostRequests.requestOtp(email);
    isLoading.value = false;
    if (response != null) {
      Get.toNamed(AppRoutes.routeVerifyOtp, arguments: {
        'email': email,
        'otp': response.data,
      });
    } else {
      Get.snackbar('error'.tr, response!.message);
    }
  }

  void pickCountryCode(BuildContext context) {
    showCountryPicker(
      context: context,
      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
      exclude: <String>['KN', 'MF'],
      favorite: <String>['US'],
      //Optional. Shows phone code before the country name.
      showPhoneCode: true,
      onSelect: (Country country) {
        print('Select country: ${country.displayName}');
        print('Select country: ${country.flagEmoji}');
        selectedCountry.value = country;
      },
      // Optional. Sets the theme for the country list picker.
      countryListTheme: CountryListThemeData(
        // Optional. Sets the border radius for the bottomsheet.
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        textStyle: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(color: AppColors.textColorPrimary),
        // Optional. Styles the search field.
        inputDecoration: InputDecoration(
            hintText: 'Start typing to search',
            hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: AppConsts.commonFontSizeFactor * 12,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(0.4)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 8),
              child: SvgPicture.asset(
                AppIcons.ic_search,
                height: 18,
                width: 18,
              ),
            ),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 18, minHeight: 18),
            filled: true,
            fillColor: AppColors.kPrimaryColor.withOpacity(0.02),
            border: inputBorderSearchCountryCode,
            errorBorder: inputBorderSearchCountryCode,
            enabledBorder: inputBorderSearchCountryCode,
            disabledBorder: inputBorderSearchCountryCode,
            focusedBorder: inputBorderSearchCountryCode,
            focusedErrorBorder: inputBorderSearchCountryCode),
      ),
    );
  }

  Future<bool> checkForLocationPermission() async {
    if (await Permission.location.isGranted) {
      return true;
    } else {
      var isGranted = await Permission.location.request().isGranted;
      if (isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }

  setupEmailTextChangeListener() {
    RxString email = ''.obs;
    emailChangeListenerWorker =
        debounce(email, (callback) => checkEmailExist(email.value));

    emailController.addListener(() {
      email.value = emailController.text.toString().trim();
      if (isShowEmailExistTip.value) {
        isShowEmailExistTip.value = false;
      }
    });
  }

  setupUsernameChangeListenerWorker() {
    RxString username = ''.obs;
    usernameChangeListenerWorker =
        debounce(username, (callback) => checkUsernameExist(username.value));

    userNameController.addListener(() {
      username.value = userNameController.text.toString().trim();
      if (isShowUsernameExistTip.value) {
        isShowUsernameExistTip.value = false;
      }
    });
  }

  setupPhoneChangeListenerWorker() {
    RxString phone = ''.obs;
    countryCodeChangeListenerWorker = debounce(selectedCountry, (callback) {
      String countryCode = selectedCountry.value.phoneCode;
      String phoneNo = phoneController.text.toString().trim();
      phone.value = countryCode + phoneNo;
    });

    phoneChangeListenerWorker = debounce(phone, (callback) {
      String countryCode = selectedCountry.value.phoneCode;
      String phoneNo = phoneController.text.toString().trim();
      checkPhoneExist(countryCode, phoneNo);
    });
    phoneController.addListener(() {
      String countryCode = selectedCountry.value.phoneCode;
      String phoneNo = phoneController.text.toString().trim();
      phone.value = countryCode + phoneNo;
      if (isShowPhoneExistTip.value) {
        isShowPhoneExistTip.value = false;
      }
    });
  }

  checkEmailExist(String email) async {
    if (AppFormatters.validEmailExp.hasMatch(email)) {
      isEmailExist.value =
          await PostRequests.checkUserExist(UserExistCheckType.email, email);
      if (isEmailExist.value) {
        isShowEmailExistTip.value = true;
      } else {
        isShowEmailExistTip.value = false;
      }
      isShowEmailExistTip.refresh();
    }
  }

  void checkUsernameExist(String username) async {
    if (username.isNotEmpty) {
      isUsernameExist.value = await PostRequests.checkUserExist(
          UserExistCheckType.username, username);
      if (isUsernameExist.value) {
        isShowUsernameExistTip.value = true;
      } else {
        isShowUsernameExistTip.value = false;
      }
      isShowUsernameExistTip.refresh();
    }
  }

  checkPhoneExist(String countryCode, String phoneNo) async {
    isPhoneExist.value = await PostRequests.checkUserExist(
        UserExistCheckType.phone, phoneNo,
        countryCode: countryCode);
    if (isPhoneExist.value) {
      isShowPhoneExistTip.value = true;
    } else {
      isShowPhoneExistTip.value = false;
    }
    isShowPhoneExistTip.refresh();
  }

  void registerUser() async {
    Map<String, dynamic> requestData = {
      'first_name': firstNameController.text.toString().trim(),
      'last_name': lastNameController.text.toString().trim(),
      'user_name': userNameController.text.toString().trim(),
      'email': emailController.text.toString().trim(),
      'phone_code': '+${selectedCountry.value.phoneCode}',
      'phone_number': phoneController.text.toString().trim(),
      'address': 'address',
      'password': passwordController.text.toString().trim(),
      'role': 'customer',
    };
    Helpers.printLog(
        screenName: "Signup_request", message: json.encode(requestData));
    isLoading.value = true;
    var result = await PostRequests.registerUser(requestData);
    isLoading.value = false;
    if (result != null) {
      if (result.success) {
        saveDataToPref(result.data!);
      } else {
        Get.snackbar('error'.tr, result.message);
      }
    }
  }

  void saveDataToPref(SignupResData signupData) {
    PreferenceManager.save2Pref(PreferenceManager.prefIsLogin, true);
    PreferenceManager.save2Pref(PreferenceManager.prefIsRememberMe, false);
    PreferenceManager.save2Pref(
        PreferenceManager.prefUserFirstName, signupData.firstName);
    PreferenceManager.save2Pref(
        PreferenceManager.prefUserLastName, signupData.lastName);
    PreferenceManager.save2Pref(
        PreferenceManager.prefUsername, signupData.userName);
    PreferenceManager.save2Pref(
        PreferenceManager.prefUserEmail, signupData.email);
    PreferenceManager.save2Pref(
        PreferenceManager.prefUserMobile, signupData.phoneNumber);
    PreferenceManager.save2Pref(PreferenceManager.prefUserId, signupData.id);
    PreferenceManager.save2Pref(
        PreferenceManager.prefUserToken, signupData.token);

    moveToWelcomeScreen();
  }

  moveToWelcomeScreen() {
    Get.toNamed(AppRoutes.routeVerificationSuccess);
  }
}
