// To parse this JSON data, do
//
//     final forgotPasswordResModel = forgotPasswordResModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResModel forgotPasswordResModelFromJson(String str) =>
    ForgotPasswordResModel.fromJson(json.decode(str));

String forgotPasswordResModelToJson(ForgotPasswordResModel data) =>
    json.encode(data.toJson());

class ForgotPasswordResModel {
  ForgotPasswordResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  int? data;

  factory ForgotPasswordResModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data,
      };
}
