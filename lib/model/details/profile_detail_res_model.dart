// To parse this JSON data, do
//
//     final profileDetailResModel = profileDetailResModelFromJson(jsonString);

import 'dart:convert';

import 'package:stylers_in_customer/model/login/login_res_model.dart';

ProfileDetailResModel profileDetailResModelFromJson(String str) =>
    ProfileDetailResModel.fromJson(json.decode(str));

String profileDetailResModelToJson(ProfileDetailResModel data) =>
    json.encode(data.toJson());

class ProfileDetailResModel {
  ProfileDetailResModel({
    required this.success,
    required this.message,
    this.profileDetailData,
  });

  bool success;
  String message;
  ProfileDetailData? profileDetailData;

  factory ProfileDetailResModel.fromJson(Map<String, dynamic> json) =>
      ProfileDetailResModel(
        success: json["success"],
        message: json["message"],
        profileDetailData: json["data"] == null
            ? null
            : ProfileDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": profileDetailData == null ? null : profileDetailData!.toJson(),
      };
}

class ProfileDetailData {
  ProfileDetailData({
    this.user,
    this.isFollow,
    this.followers,
    this.followersCount,
    this.services,
    this.portfolio,
    this.reviews,
    this.rating,
    this.publicPosts,
  });

  User? user;
  int? isFollow;
  List<Follower>? followers;
  FollowersCount? followersCount;
  List<Service>? services;
  List<Portfolio>? portfolio;
  List<Review>? reviews;
  int? rating;
  List<PublicPost>? publicPosts;

  factory ProfileDetailData.fromJson(Map<String, dynamic> json) =>
      ProfileDetailData(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        isFollow: json["is_follow"],
        followers: json["followers"] == null
            ? null
            : List<Follower>.from(
                json["followers"].map((x) => Follower.fromJson(x))),
        followersCount: json["followers_count"] == null
            ? null
            : FollowersCount.fromJson(json["followers_count"]),
        services: json["services"] == null
            ? null
            : List<Service>.from(
                json["services"].map((x) => Service.fromJson(x))),
        portfolio: json["portfolio"] == null
            ? null
            : List<Portfolio>.from(
                json["portfolio"].map((x) => Portfolio.fromJson(x))),
        reviews: json["reviews"] == null
            ? null
            : List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        rating: json["rating"],
        publicPosts: json["public_posts"] == null
            ? null
            : List<PublicPost>.from(
                json["public_posts"].map((x) => PublicPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
        "is_follow": isFollow,
        "followers": followers == null
            ? null
            : List<dynamic>.from(followers!.map((x) => x.toJson())),
        "followers_count":
            followersCount == null ? null : followersCount!.toJson(),
        "services": services == null
            ? null
            : List<dynamic>.from(services!.map((x) => x.toJson())),
        "portfolio": portfolio == null
            ? null
            : List<dynamic>.from(portfolio!.map((x) => x.toJson())),
        "reviews": reviews == null
            ? null
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "rating": rating,
        "public_posts": publicPosts == null
            ? null
            : List<dynamic>.from(publicPosts!.map((x) => x.toJson())),
      };
}

class Follower {
  Follower({
    this.id,
    this.userId,
    this.follower,
    this.isConnected,
    this.createdAt,
    this.updatedAt,
    this.userImage,
    this.user,
  });

  int? id;
  int? userId;
  int? follower;
  int? isConnected;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userImage;
  User? user;

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        id: json["id"],
        userId: json["user_id"],
        follower: json["follower"],
        isConnected: json["is_connected"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userImage: json["user_image"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "follower": follower,
        "is_connected": isConnected,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "user_image": userImage,
        "user": user == null ? null : user!.toJson(),
      };
}

class FollowersCount {
  FollowersCount({
    this.totalFollwers,
  });

  int? totalFollwers;

  factory FollowersCount.fromJson(Map<String, dynamic> json) => FollowersCount(
        totalFollwers: json["total_follwers"],
      );

  Map<String, dynamic> toJson() => {
        "total_follwers": totalFollwers,
      };
}

class Portfolio {
  Portfolio({
    this.id,
    this.userId,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? description;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        id: json["id"],
        userId: json["user_id"],
        description: json["description"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "description": description,
        "image": image,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class PublicPost {
  PublicPost({
    this.id,
    this.userId,
    this.thought,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.longitude,
    this.latitude,
    this.address,
    this.totalLikes,
    this.totalComments,
    this.user,
  });

  int? id;
  int? userId;
  String? thought;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? longitude;
  double? latitude;
  String? address;
  int? totalLikes;
  int? totalComments;
  User? user;

  factory PublicPost.fromJson(Map<String, dynamic> json) => PublicPost(
        id: json["id"],
        userId: json["user_id"],
        thought: json["thought"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        longitude: json["longitude"],
        latitude: json["latitude"],
        address: json["address"],
        totalLikes: json["total_likes"],
        totalComments: json["total_comments"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "thought": thought,
        "image": image,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "longitude": longitude,
        "latitude": latitude,
        "address": address,
        "total_likes": totalLikes,
        "total_comments": totalComments,
        "user": user == null ? null : user!.toJson(),
      };
}

class Review {
  Review({
    this.id,
    this.userId,
    this.ratingTo,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? userId;
  int? ratingTo;
  String? rating;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user_id"],
        ratingTo: json["rating_to"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "rating_to": ratingTo,
        "rating": rating,
        "comment": comment,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "user": user == null ? null : user!.toJson(),
      };
}

class Service {
  Service({
    this.serviceName,
    this.subServices,
  });

  String? serviceName;
  List<SubService>? subServices;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceName: json["service_name"] == null ? null : json["service_name"],
        subServices: json["sub_services"] == null
            ? null
            : List<SubService>.from(
                json["sub_services"].map((x) => SubService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service_name": serviceName == null ? null : serviceName,
        "sub_services": subServices == null
            ? null
            : List<dynamic>.from(subServices!.map((x) => x.toJson())),
      };
}

class SubService {
  SubService({
    required this.id,
    this.userId,
    this.serviceId,
    this.subServiceId,
    this.rate,
    this.createdAt,
    this.updatedAt,
    this.subServiceName,
    this.subService,
    this.service,
  });

  int id;
  int? userId;
  int? serviceId;
  int? subServiceId;
  String? rate;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? subServiceName;
  SubServiceClass? subService;
  SubServiceClass? service;

  factory SubService.fromJson(Map<String, dynamic> json) => SubService(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        serviceId: json["service_id"] == null ? null : json["service_id"],
        subServiceId:
            json["sub_service_id"] == null ? null : json["sub_service_id"],
        rate: json["rate"] == null ? null : json["rate"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        subServiceName:
            json["sub_service_name"] == null ? null : json["sub_service_name"],
        subService: json["sub_service"] == null
            ? null
            : SubServiceClass.fromJson(json["sub_service"]),
        service: json["service"] == null
            ? null
            : SubServiceClass.fromJson(json["service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "service_id": serviceId == null ? null : serviceId,
        "sub_service_id": subServiceId == null ? null : subServiceId,
        "rate": rate == null ? null : rate,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "sub_service_name": subServiceName == null ? null : subServiceName,
        "sub_service": subService == null ? null : subService!.toJson(),
        "service": service == null ? null : service!.toJson(),
      };
}

class SubServiceClass {
  SubServiceClass({
    required this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.serviceId,
  });

  int id;
  String? name;
  String? image;
  dynamic createdAt;
  dynamic updatedAt;
  int? serviceId;

  factory SubServiceClass.fromJson(Map<String, dynamic> json) =>
      SubServiceClass(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        serviceId: json["service_id"] == null ? null : json["service_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "service_id": serviceId == null ? null : serviceId,
      };
}

// class Service {
//   Service({
//     this.id,
//     this.userId,
//     this.serviceId,
//     this.subServiceId,
//     this.rate,
//     this.createdAt,
//     this.updatedAt,
//     this.subService,
//   });
//
//   int? id;
//   int? userId;
//   int? serviceId;
//   int? subServiceId;
//   String? rate;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   SubService? subService;
//
//   factory Service.fromJson(Map<String, dynamic> json) => Service(
//     id:  json["id"],
//     userId:  json["user_id"],
//     serviceId:  json["service_id"],
//     subServiceId:  json["sub_service_id"],
//     rate:  json["rate"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     subService: json["sub_service"] == null ? null : SubService.fromJson(json["sub_service"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id":  id,
//     "user_id":  userId,
//     "service_id":  serviceId,
//     "sub_service_id":  subServiceId,
//     "rate":  rate,
//     "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
//     "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
//     "sub_service": subService == null ? null : subService!.toJson(),
//   };
// }
//
// class SubService {
//   SubService({
//     this.id,
//     this.serviceId,
//     this.name,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   int? id;
//   int? serviceId;
//   String? name;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   factory SubService.fromJson(Map<String, dynamic> json) => SubService(
//     id:  json["id"],
//     serviceId:  json["service_id"],
//     name:  json["name"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id":  id,
//     "service_id":  serviceId,
//     "name":  name,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }
