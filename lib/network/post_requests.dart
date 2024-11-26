import 'package:http/http.dart' as http;

import 'package:stylers_in_customer/model/base_res_model.dart';
import 'package:stylers_in_customer/model/common_res_model.dart';
import 'package:stylers_in_customer/model/search/search_res_model.dart';
import 'package:stylers_in_customer/model/signup/signup_res_model.dart';
import 'package:stylers_in_customer/network/remote_services.dart';
import 'package:stylers_in_customer/network/request_headers.dart';

import '../model/appointment/booking_free_time_slots_res_model.dart';
import '../model/appointment/create_appointment_res_model.dart';
import '../model/appointment/provider_sub_services_res_model.dart';
import '../model/calendar/calendar_appointments_res_model.dart';
import '../model/detailed_post/create_comment_res_model.dart';
import '../model/follow/follow_res_model.dart';
import '../model/forgot_password/forgot_password_res_model.dart';
import '../model/home/home_data_res_model.dart';
import '../model/login/login_res_model.dart';
import '../model/login/social_login_res_model.dart';
import '../model/news_feed/toggle_favorite_status_res_model.dart';
import '../model/profile/edit_profile_res_model.dart';
import '../model/shops/shops_res_model.dart';
import '../model/signup/request_otp_res_model.dart';
import '../utils/enums/search_type.dart';
import '../utils/enums/user_exist_check_type.dart';
import 'ApiUrls.dart';

class PostRequests {
  PostRequests._();

  static Future<BaseResModel?> cancelAppointment(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(ApiUrls.cancelAppointment,
        requestBody: requestBody, headers: RequestHeaders.getAcceptAndContentType());

    if (apiResponse != null) {
      return baseResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<LoginResModel?> loginUser(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(ApiUrls.login,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return loginResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<SocialLoginResModel?> socialLogin(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(ApiUrls.socialLogin,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return socialLoginResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<CreateCommentResModel?> createComment(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(ApiUrls.createComment,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return createCommentResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResModel?> changeForgottenPassword(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(ApiUrls.newPassword,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);
    if (apiResponse != null) {
      return baseResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<bool> checkUserExist(checkType, String value,
      {String? countryCode}) async {
    Map<String, String> requestBody = {'type': 'type', 'value': 'value'};
    if (checkType == UserExistCheckType.email) {
      requestBody = {'type': 'email', 'value': value};
    } else if (checkType == UserExistCheckType.phone) {
      requestBody = {
        'type': 'phone_number',
        'value': value,
        'code': '+${countryCode!}',
      };
    } else if (checkType == UserExistCheckType.username) {
      requestBody = {'type': 'user_name', 'value': value};
    }

    var apiResponse = await RemoteService.simplePost(ApiUrls.checkUserExist,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      var response = baseResModelFromJson(apiResponse.response!);
      return !response.success;
    } else {
      return true;
    }
  }

  static Future<SearchResModel?> searchText(
      String searchText, searchType) async {
    Map<String, String> requestBody = {'search': 'search'};
    if (searchType == SearchType.all) {
      requestBody = {'search': searchText};
    } else if (searchType == SearchType.stylist) {
      requestBody = {'search': searchText, 'type': 'stylists'};
    } else if (searchType == SearchType.shop) {
      requestBody = {'search': searchText, 'type': 'shops'};
    } else if (searchType == SearchType.service) {
      requestBody = {'search': searchText, 'type': 'services'};
    }

    var apiResponse = await RemoteService.simplePost(ApiUrls.search,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      var response = searchResModelFromJson(apiResponse.response!);
      return response;
    } else {
      return null;
    }
  }

  // static Future<RequestOtpResModel?> requestOtp(String email) async {
  //   var requestBody = {'email': email};
  //   var apiResponse =
  //       await RemoteService.simplePost(requestBody, ApiUrls.requestOtp);
  //
  //   if (apiResponse != null) {
  //     return requestOtpResModelFromJson(apiResponse.response!);
  //   } else {
  //     return null;
  //   }
  // }
  static Future<RequestOtpResModel?> requestOtp(String email) async {
    var requestBody = {'email': email};
    var apiResponse = await RemoteService.simplePost(ApiUrls.requestOtp,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return requestOtpResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<SignupResModel?> registerUser(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(ApiUrls.signup,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return signupResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<CreateAppointmentResModel?> createAppointment(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(ApiUrls.createAppointment,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return createAppointmentResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BookingFreeTimeSlotsResModel?> getBookingFreeTimeSlots(
      Map<String, dynamic> requestBody, int providerId) async {
    var apiResponse = await RemoteService.simplePost(
        '${ApiUrls.bookingFreeTimeSlots}$providerId',
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return bookingFreeTimeSlotsResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<ForgotPasswordResModel?> forgotPassword(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(ApiUrls.forgotPassword,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return forgotPasswordResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<HomeDataResModel?> getHomeData(
      {Map<String, dynamic>? requestBody}) async {
    CommonResModel? apiResponse;
    if (requestBody != null) {
      apiResponse = await RemoteService.simplePost(ApiUrls.homeData,
          headers: RequestHeaders.getAcceptAndContentType(),
          requestBody: requestBody);
    } else {
      apiResponse = await RemoteService.simplePost(
        ApiUrls.homeData,
        headers: RequestHeaders.getAcceptAndContentType(),
      );
    }

    if (apiResponse != null) {
      return homeDataResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResModel?> createPost(
      String thought, List<String>? images) async {
    var apiResponse =
        await RemoteService.createPost(images, ApiUrls.createPost, thought);

    if (apiResponse != null) {
      return baseResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<FollowResModel?> follow(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(ApiUrls.follow,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return followResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<ProviderSubServicesResModel?> getProviderSubServices(
      Map<String, dynamic> requestBody, int providerId) async {
    var apiResponse = await RemoteService.simplePost(
        '${ApiUrls.providerSubServices}$providerId',
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return providerSubServicesResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<ShopsResModel?> getShops(
      Map<String, dynamic>? requestBody) async {
    var apiResponse = await RemoteService.simplePost(
      ApiUrls.shops,
      headers: RequestHeaders.getAcceptAndContentType(),
      requestBody: requestBody,
    );

    if (apiResponse != null) {
      return shopsResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<ToggleFavoriteStatusResModel?> toggleFavoriteStatus(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(
        ApiUrls.toggleFavoriteStatus,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return toggleFavoriteStatusResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResModel?> toggleCommentFavoriteStatus(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(
        ApiUrls.toggleCommentFavoriteStatus,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return baseResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<EditProfileResModel?> editProfileData(
      http.MultipartFile? uploadMedia, Map<String, String> requestBody) async {
    var apiResponse = await RemoteService.postWithMedia(
        uploadMedia, ApiUrls.editProfile, requestBody);

    if (apiResponse != null) {
      return editProfileResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResModel?> changePassword(
      Map<String, String> requestBody) async {
    var apiResponse = await RemoteService.simplePost(ApiUrls.changePassword,
        headers: RequestHeaders.getAcceptAndContentType(),
        requestBody: requestBody);

    if (apiResponse != null) {
      return baseResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<HomeDataResModel?> getGuestHomeData(
      {required Map<String, dynamic>? requestBody}) async {
    var apiResponse;
    // if (requestBody!.isEmpty) {
    apiResponse = await RemoteService.simplePost(ApiUrls.guestHomeData,
        headers: RequestHeaders.getAcceptJsonHeader(),
        requestBody: requestBody);
    // } else {
    //   apiResponse = await RemoteService.simplePostWithoutToken(
    //       ApiUrls.guestHomeData,
    //       requestBody: requestBody);
    // }

    if (apiResponse != null) {
      return homeDataResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<CalendarAppointmentsResModel?> getCalendarAppointments(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(
        ApiUrls.calendarAppointments,
        requestBody: requestBody,
        headers: RequestHeaders.getAcceptAndContentType());

    if (apiResponse != null) {
      return calendarAppointmentsResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }
}
