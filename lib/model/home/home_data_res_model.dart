// To parse this JSON data, do
//
//     final homeDataResModel = homeDataResModelFromJson(jsonString);

import 'dart:convert';

import 'package:stylers_in_customer/model/login/login_res_model.dart';

import '../services/services_res_model.dart';

HomeDataResModel homeDataResModelFromJson(String str) => HomeDataResModel.fromJson(json.decode(str));

String homeDataResModelToJson(HomeDataResModel data) => json.encode(data.toJson());

class HomeDataResModel {
  HomeDataResModel({
   required this.success,
   required this.message,
    this.homeData,
  });

  bool success;
  String message;
  HomeData? homeData;

  factory HomeDataResModel.fromJson(Map<String, dynamic> json) => HomeDataResModel(
    success:  json["success"],
    message:  json["message"],
    homeData: json["data"] == null ? null : HomeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": homeData == null ? null : homeData!.toJson(),
  };
}

class HomeData {
  HomeData({
    this.user,
    this.banners,
    this.services,
    this.popularStylists,
    this.shopOpeningsNearYou,
  });

  User? user;
  List<HomeBanner>? banners;
  List<Service>? services;
  List<User>? popularStylists;
  List<User>? shopOpeningsNearYou;

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    user: json["user_detail"] == null ? null : User.fromJson(json["user_detail"]),
    banners: json["banner"] == null ? null : List<HomeBanner>.from(json["banner"].map((x) => HomeBanner.fromJson(x))),
    services: json["services"] == null ? null : List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    popularStylists: json["popular_stylists"] == null ? null : List<User>.from(json["popular_stylists"].map((x) => User.fromJson(x))),
    shopOpeningsNearYou: json["shop_openings_near_you"] == null ? null : List<User>.from(json["shop_openings_near_you"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_detail": user == null ? null : user!.toJson(),
    "banner": banners == null ? null : List<dynamic>.from(banners!.map((x) => x.toJson())),
    "services": services == null ? null : List<dynamic>.from(services!.map((x) => x.toJson())),
    "popular_stylists": popularStylists == null ? null : List<dynamic>.from(popularStylists!.map((x) => x.toJson())),
    "shop_openings_near_you": shopOpeningsNearYou == null ? null : List<dynamic>.from(shopOpeningsNearYou!.map((x) => x.toJson())),
  };
}

class HomeBanner {
  HomeBanner({
    required this.id,
    this.title,
    this.subTitle,
    this.description,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String? title;
  String? subTitle;
  String? description;
  String? image;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HomeBanner.fromJson(Map<String, dynamic> json) => HomeBanner(
    id:  json["id"],
    title:  json["title"],
    subTitle:  json["sub_title"],
    description:  json["description"],
    image:  json["image"],
    status:  json["status"],
    createdAt:  DateTime.parse(json["created_at"]),
    updatedAt:  DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title":  title,
    "sub_title": subTitle,
    "description":  description,
    "image":  image,
    "status":  status,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}





