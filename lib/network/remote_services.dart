import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/common_res_model.dart';
import '../utils/helpers.dart';
import '../utils/internet_connection.dart';
import '../utils/preference_manager.dart';

class RemoteService {
  static var client = http.Client();
  static const String _baseUrl = "https://stylersin.appdeft.biz/api/";

  static Future<Map<String, String>> getHeadersFileUpload() async {
    String? bearerToken =
        PreferenceManager.getPref(PreferenceManager.prefUserToken) as String?;
    Map<String, String> headers = {
      // "Accept": "application/json",
      // "Content-Type": "application/json;charset=utf-8"
    };

    if (bearerToken != null) {
      headers.addAll({"Authorization": "Bearer $bearerToken"});
    }
    return headers;
  }

  static Future<CommonResModel?> simplePost(
    String endUrl, {
    required Map<String, String> headers,
    Map<String, dynamic>? requestBody,
  }) async {
    var isConnected = await InternetConnection.isConnected();

    if (!isConnected) {
      return null;
    }

    Helpers.printLog(
        screenName: 'Remote_Service_simple_post',
        message: "request_data = $requestBody");
    debugPrint('request_URL = ${_baseUrl + endUrl}');
    debugPrint('request_headers = ${json.encode(headers)}');

    var body = json.encode(requestBody);
    final http.Response response;
    if (requestBody != null) {
      response = await http.post(Uri.parse(_baseUrl + endUrl),
          headers: headers, body: body);
    } else {
      response =
          await http.post(Uri.parse(_baseUrl + endUrl), headers: headers);
    }

    Helpers.printLog(
        screenName: 'Remote_Service_simple_post',
        message: "response = ${response.body}");
    debugPrint('request_URL = ${_baseUrl + endUrl}');
    debugPrint('request_headers = ${json.encode(headers)}');
    var responseCode = response.statusCode;
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResModel(statusCode: responseCode, response: response.body);
    } else {
      return null;
    }
  }

  static Future<CommonResModel?> simpleGet(
    String endUrl, {
    required Map<String, String> headers,
  }) async {
    var isConnected = await InternetConnection.isConnected();

    if (!isConnected) {
      return null;
    }
    Helpers.printLog(
        screenName: 'Remote_Service_simple_get', message: "request_data =");
    debugPrint('request_URL = ${_baseUrl + endUrl}');
    debugPrint('request_headers = ${json.encode(headers)}');
    final response =
        await http.get(Uri.parse(_baseUrl + endUrl), headers: headers);
    Helpers.printLog(
        screenName: 'Remote_Service_simple_get',
        message: "response = ${response.body}");
    debugPrint('request_URL = ${_baseUrl + endUrl}');
    debugPrint('request_headers = ${json.encode(headers)}');

    var responseCode = response.statusCode;
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResModel(statusCode: responseCode, response: response.body);
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
      return null;
    }
  }

  static Future<CommonResModel?> createPost(
      List<String>? paths, String endUrl, String thought) async {
    var isConnected = await InternetConnection.isConnected();

    if (!isConnected) {
      return null;
    }

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(_baseUrl + endUrl));
    request.fields['thought'] = thought;
    request.headers.addAll(await getHeadersFileUpload());
    if (paths != null) {
      // print('paths is not null');
      for (int x = 0; x < paths.length; x++) {
        request.files
            .add(await http.MultipartFile.fromPath('media[$x]', paths[x]));
      }
    }

    http.StreamedResponse streamedResponse = await request.send();
    // var responseBytes = await streamedResponse.stream.toBytes();
    // var responseString =  utf8.decode(responseBytes);

    var response = await http.Response.fromStream(streamedResponse);
    Helpers.printLog(
        screenName: 'Remote_Service_create_post',
        message: "response = ${response.body}");
    var responseCode = response.statusCode;
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResModel(statusCode: responseCode, response: response.body);
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
      return null;
    }
  }

  static Future<CommonResModel?> postWithMedia(http.MultipartFile? uploadMedia,
      String endUrl, Map<String, String> requestBody) async {
    var isConnected = await InternetConnection.isConnected();

    if (!isConnected) {
      return null;
    }

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(_baseUrl + endUrl));
    requestBody.forEach((key, value) {
      request.fields[key] = value;
    });
    if (uploadMedia != null) {
      request.files.add(uploadMedia);
    }
    request.headers.addAll(await getHeadersFileUpload());
    Helpers.printLog(
        screenName: 'Remote_Service_post_with_single_media',
        message: "request_data = ${request.fields}");

    http.StreamedResponse streamedResponse = await request.send();
    // var responseBytes = await streamedResponse.stream.toBytes();
    // var responseString =  utf8.decode(responseBytes);

    var response = await http.Response.fromStream(streamedResponse);
    Helpers.printLog(
        screenName: 'Remote_Service_post_with_single_media',
        message: "response = ${response.body}");
    var responseCode = response.statusCode;
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResModel(statusCode: responseCode, response: response.body);
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
      return null;
    }
  }
}
