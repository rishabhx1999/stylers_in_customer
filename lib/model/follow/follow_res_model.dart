// To parse this JSON data, do
//
//     final followResModel = followResModelFromJson(jsonString);

import 'dart:convert';

import '../details/profile_detail_res_model.dart';

FollowResModel followResModelFromJson(String str) =>
    FollowResModel.fromJson(json.decode(str));

String followResModelToJson(FollowResModel data) => json.encode(data.toJson());

class FollowResModel {
  FollowResModel(
      {required this.success, required this.message, this.status, this.data});

  bool success;
  String message;
  int? status;
  Follower? data;

  factory FollowResModel.fromJson(Map<String, dynamic> json) => FollowResModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Follower.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "status": status == null ? null : status,
        "data": data == null ? null : data!.toJson(),
      };
}
