import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stylers_in_customer/config/app_routes.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../model/login/login_res_model.dart';
import '../../network/post_requests.dart';
import '../../utils/enums/login_type.dart';
import '../../utils/preference_manager.dart';

class LoginController extends GetxController {
  late GoogleSignIn _googleSignIn;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey();
  RxBool isRememberMe = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSocialLoginLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _googleSignIn = GoogleSignIn(scopes: ['email']);
    initializeLoginTextFields();
    checkIsUserRemember();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void initializeLoginTextFields() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void checkIsUserRemember() {
    if (PreferenceManager.isUserRemembered()) {
      emailController.text =
          (PreferenceManager.getPref(PreferenceManager.prefUserEmail)
                  as String?) ??
              "";
      passwordController.text =
          (PreferenceManager.getPref(PreferenceManager.prefUserPassword)
                  as String?) ??
              "";
    }
  }

  void signIn() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> requestBody = {
        'email': emailController.text.toString().trim(),
        'password': passwordController.text.toString().trim(),
        'is_customer': '1'
      };

      isLoading.value = true;
      var response = await PostRequests.loginUser(requestBody);
      isLoading.value = false;
      if (response != null) {
        if (response.success) {
          saveDataToPref(response.user!, LoginType.manual);
        } else {
          Get.snackbar('error'.tr, response.message);
        }
      } else {
        Get.snackbar('error'.tr, 'message_server_error'.tr);
      }
    }

    //  if(formKey.currentState!.validate()){
    // Get.offAllNamed(AppRoutes.routeDashboard);
    //  }
  }

  void saveDataToPref(dynamic loginData, LoginType loginType) {
    PreferenceManager.save2Pref(PreferenceManager.prefIsLogin, true);

    if (loginType == LoginType.manual) {
      PreferenceManager.save2Pref(
          PreferenceManager.prefIsRememberMe, isRememberMe.value);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserFirstName, loginData.firstName);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserLastName, loginData.lastName);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUsername, loginData.userName);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserEmail, loginData.email);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserMobile, loginData.phoneNumber);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserAddress, loginData.address1);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserCity, loginData.city);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserProvince, loginData.state);
      if (loginData.zipCode != null && loginData.zipCode != '') {
        PreferenceManager.save2Pref(PreferenceManager.prefUserPostalCode,
            int.parse(loginData.zipCode!));
      }
      PreferenceManager.save2Pref(PreferenceManager.prefUserId, loginData.id);
      debugPrint('CUSTOMER_ID = ${loginData.id}');
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserToken, loginData.token);

      if (loginData.avatar != null) {
        PreferenceManager.save2Pref(
            PreferenceManager.prefUserImage, loginData.avatar);
      }
      if (isRememberMe.value) {
        PreferenceManager.save2Pref(
            PreferenceManager.prefUserEmail, emailController.text.trim());
        PreferenceManager.save2Pref(
            PreferenceManager.prefUserPassword, passwordController.text.trim());
      } else {
        PreferenceManager.save2Pref(PreferenceManager.prefUserEmail, '');
        PreferenceManager.save2Pref(PreferenceManager.prefUserPassword, '');
      }
    }

    if (loginType == LoginType.social) {
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserFirstName, loginData.firstName);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserLastName, loginData.lastName);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUsername, loginData.userName);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserEmail, loginData.email);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserMobile, loginData.phoneNumber);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserAddress, loginData.address1);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserCity, loginData.city);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserProvince, loginData.state);
      if (loginData.zipCode != null && loginData.zipCode != '') {
        PreferenceManager.save2Pref(PreferenceManager.prefUserPostalCode,
            int.parse(loginData.zipCode!));
      }
      PreferenceManager.save2Pref(PreferenceManager.prefUserId, loginData.id);
      PreferenceManager.save2Pref(
          PreferenceManager.prefUserToken, loginData.token);

      if (loginData.avatar != null) {
        PreferenceManager.save2Pref(
            PreferenceManager.prefUserImage, loginData.avatar);
      }
    }

    moveToDashBoard();
  }

  void moveToDashBoard() {
    Get.offAllNamed(AppRoutes.routeDashboard);
  }

  loginWithFb() async {
    FacebookAuth.instance.logOut();
    FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((userData) {
        socialLogin(
            userData['name'], userData['email'], userData['id'], 'facebook');
      });
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void loginWithGoogle() {
    _googleSignIn.signOut();
    _googleSignIn.signIn().then((account) {
      debugPrint('GOOGLE_ACCOUNT $account');
      socialLogin(account!.displayName, account.email, account.id, 'google');
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void socialLogin(String? name, String email, String socialId,
      String socialProvider) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Map<String, dynamic> requestBody = {
      'name': name,
      'email': email,
      'role': 'customer',
      'social_id': socialId,
      'social_provider': socialProvider
    };

    isSocialLoginLoading.value = true;
    var response = await PostRequests.socialLogin(requestBody);
    isSocialLoginLoading.value = false;
    if (response != null) {
      if (response.success && response.data != null) {
        saveDataToPref(response.data, LoginType.social);
      } else {
        Get.snackbar('error'.tr, response.message);
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
  }

  @override
  void onClose() {
    debugPrint('Login onClose');
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }
}
