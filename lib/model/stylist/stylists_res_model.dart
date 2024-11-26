// To parse this JSON data, do
//
//     final stylistsResModel = stylistsResModelFromJson(jsonString);

import 'dart:convert';

import 'package:stylers_in_customer/model/login/login_res_model.dart';
import 'package:stylers_in_customer/model/search/search_res_model.dart';

StylistsResModel stylistsResModelFromJson(String str) => StylistsResModel.fromJson(json.decode(str));

String stylistsResModelToJson(StylistsResModel data) => json.encode(data.toJson());

class StylistsResModel {
  StylistsResModel({
    required this.success,
    required this.message,
    this.stylists,
  });

  bool success;
  String message;
  List<User>? stylists;

  factory StylistsResModel.fromJson(Map<String, dynamic> json) => StylistsResModel(
    success:  json["success"],
    message:  json["message"],
    stylists: json["data"] == null ? null : List<User>.from(json["data"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success":  success,
    "message":  message,
    "data": stylists == null ? null : List<dynamic>.from(stylists!.map((x) => x.toJson())),
  };
}




