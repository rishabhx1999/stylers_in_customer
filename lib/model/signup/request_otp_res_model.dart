// To parse this JSON data, do
//
//     final requestOtpResModel = requestOtpResModelFromJson(jsonString);

import 'dart:convert';

RequestOtpResModel requestOtpResModelFromJson(String str) => RequestOtpResModel.fromJson(json.decode(str));

String requestOtpResModelToJson(RequestOtpResModel data) => json.encode(data.toJson());

class RequestOtpResModel {
  RequestOtpResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  int? data;

  factory RequestOtpResModel.fromJson(Map<String, dynamic> json) => RequestOtpResModel(
    success: json["success"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
  };
}
