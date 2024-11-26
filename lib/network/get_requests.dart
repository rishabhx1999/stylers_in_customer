import 'package:stylers_in_customer/model/details/profile_detail_res_model.dart';
import 'package:stylers_in_customer/model/home/home_data_res_model.dart';
import 'package:stylers_in_customer/model/services/services_res_model.dart';
import 'package:stylers_in_customer/model/shops/shops_res_model.dart';
import 'package:stylers_in_customer/model/stylist/stylists_res_model.dart';
import 'package:stylers_in_customer/network/remote_services.dart';
import 'package:stylers_in_customer/network/request_headers.dart';

import '../model/appointment/appointment_detail_res_model.dart';
import '../model/appointment/provider_services_res_model.dart';
import '../model/customer_profile/customer_profile_detail_res_model.dart';
import '../model/detailed_post/detailed_post_res_model.dart';
import '../model/followers_list/followers_list_res_model.dart';
import '../model/news_feed/posts_res_model.dart';
import 'ApiUrls.dart';

class GetRequests {
  GetRequests._();

  static Future<PostsResModel?> getPosts() async {
    var apiResponse = await RemoteService.simpleGet(ApiUrls.newsFeed,
        headers: RequestHeaders.getAcceptAndContentType());

    if (apiResponse != null) {
      return postsResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<PostsResModel?> getGuestPosts() async {
    var apiResponse = await RemoteService.simpleGet(ApiUrls.guestNewsFeed,
        headers: RequestHeaders.getAcceptAndContentType(token: false));

    if (apiResponse != null) {
      return postsResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  // profile detail for stylists and shops
  static Future<ProfileDetailResModel?> getProfileDetail(int id) async {
    var apiResponse = await RemoteService.simpleGet(
      '${ApiUrls.viewProfile}$id',
      headers: RequestHeaders.getAcceptAndContentType(),
    );

    if (apiResponse != null) {
      return profileDetailResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<AppointmentDetailResModel?> getAppointmentDetail(
      int appointmentId) async {
    var apiResponse = await RemoteService.simpleGet(
      '${ApiUrls.appointmentDetail}$appointmentId',
      headers: RequestHeaders.getAcceptAndContentType(),
    );

    if (apiResponse != null) {
      return appointmentDetailResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<ServicesResModel?> getServices() async {
    var apiResponse = await RemoteService.simpleGet(
      ApiUrls.services,
      headers: RequestHeaders.getAcceptAndContentType(),
    );

    if (apiResponse != null) {
      return servicesResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<StylistsResModel?> getStylists() async {
    var apiResponse = await RemoteService.simpleGet(
      ApiUrls.popularStylists,
      headers: RequestHeaders.getAcceptAndContentType(),
    );

    if (apiResponse != null) {
      return stylistsResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<ProviderServicesResModel?> getProviderServices(
      int providerId) async {
    var apiResponse = await RemoteService.simpleGet(
      '${ApiUrls.providerServices}$providerId',
      headers: RequestHeaders.getAcceptAndContentType(),
    );

    if (apiResponse != null) {
      return providerServicesResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<DetailedPostResModel?> getPostDetails(int postId) async {
    var apiResponse = await RemoteService.simpleGet(
      '${ApiUrls.detailedPost}/$postId',
      headers: RequestHeaders.getAcceptAndContentType(),
    );

    if (apiResponse != null) {
      return detailedPostResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<FollowersListResModel?> getProviderFollowers(
      int providerId) async {
    var apiResponse = await RemoteService.simpleGet(
      '${ApiUrls.providerFollowersList}$providerId',
      headers: RequestHeaders.getAcceptAndContentType(),
    );

    if (apiResponse != null) {
      return followersListResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<FollowersListResModel?> getCustomerFollowers() async {
    var apiResponse = await RemoteService.simpleGet(
      ApiUrls.customerFollowersList,
      headers: RequestHeaders.getAcceptAndContentType(),
    );

    if (apiResponse != null) {
      return followersListResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<CustomerProfileDetailResModel?>
      getCustomerProfileDetails() async {
    var apiResponse = await RemoteService.simpleGet(
      ApiUrls.customerProfileDetails,
      headers: RequestHeaders.getAcceptAndContentType(),
    );

    if (apiResponse != null) {
      return customerProfileDetailResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }
}
