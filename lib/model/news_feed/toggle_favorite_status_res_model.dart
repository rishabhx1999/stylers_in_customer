// To parse this JSON data, do
//
//     final toggleFavoriteStatusResModel = toggleFavoriteStatusResModelFromJson(jsonString);

import 'dart:convert';

ToggleFavoriteStatusResModel toggleFavoriteStatusResModelFromJson(String str) =>
    ToggleFavoriteStatusResModel.fromJson(json.decode(str));

String toggleFavoriteStatusResModelToJson(ToggleFavoriteStatusResModel data) =>
    json.encode(data.toJson());

class ToggleFavoriteStatusResModel {
  ToggleFavoriteStatusResModel({
    required this.success,
    required this.message,
    this.status,
  });

  bool success;
  String message;
  int? status;

  factory ToggleFavoriteStatusResModel.fromJson(Map<String, dynamic> json) =>
      ToggleFavoriteStatusResModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "status": status == null ? null : status,
      };
}
