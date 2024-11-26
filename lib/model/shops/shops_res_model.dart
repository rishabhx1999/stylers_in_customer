// To parse this JSON data, do
//
//     final shopsResModel = shopsResModelFromJson(jsonString);

import 'dart:convert';

import 'package:stylers_in_customer/model/login/login_res_model.dart';

ShopsResModel shopsResModelFromJson(String str) => ShopsResModel.fromJson(json.decode(str));

String shopsResModelToJson(ShopsResModel data) => json.encode(data.toJson());

class ShopsResModel {
  ShopsResModel({
   required this.success,
   required this.message,
    this.shopsData,
  });

  bool success;
  String message;
  ShopsData? shopsData;

  factory ShopsResModel.fromJson(Map<String, dynamic> json) => ShopsResModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    shopsData: json["data"] == null ? null : ShopsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "data": shopsData == null ? null : shopsData!.toJson(),
  };
}

class ShopsData {
  ShopsData({
    this.shopsOpeningNearYou,
    this.topRatedShops,
    this.suggestedForYou,
  });

  List<User>? shopsOpeningNearYou;
  List<User>? topRatedShops;
  List<User>? suggestedForYou;

  factory ShopsData.fromJson(Map<String, dynamic> json) => ShopsData(
    shopsOpeningNearYou: json["shops_opening_near_you"] == null ? null : List<User>.from(json["shops_opening_near_you"].map((x) => x)),
    topRatedShops: json["top_rated_shops"] == null ? null : List<User>.from(json["top_rated_shops"].map((x) => User.fromJson(x))),
    suggestedForYou: json["suggested_for_you"] == null ? null : List<User>.from(json["suggested_for_you"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "shops_opening_near_you": shopsOpeningNearYou == null ? null : List<dynamic>.from(shopsOpeningNearYou!.map((x) => x)),
    "top_rated_shops": topRatedShops == null ? null : List<dynamic>.from(topRatedShops!.map((x) => x.toJson())),
    "suggested_for_you": suggestedForYou == null ? null : List<dynamic>.from(suggestedForYou!.map((x) => x.toJson())),
  };
}

