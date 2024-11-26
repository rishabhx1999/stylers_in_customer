// To parse this JSON data, do
//
//     final detailedPostResModel = detailedPostResModelFromJson(jsonString);

import 'dart:convert';

import '../news_feed/posts_res_model.dart';

DetailedPostResModel detailedPostResModelFromJson(String str) =>
    DetailedPostResModel.fromJson(json.decode(str));

String detailedPostResModelToJson(DetailedPostResModel data) =>
    json.encode(data.toJson());

class DetailedPostResModel {
  DetailedPostResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  DetailedPost? data;

  factory DetailedPostResModel.fromJson(Map<String, dynamic> json) =>
      DetailedPostResModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : DetailedPost.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class DetailedPost {
  DetailedPost({
    this.post,
    this.comments,
    this.isLike,
  });

  PostData? post;
  List<Comment>? comments;
  int? isLike;

  factory DetailedPost.fromJson(Map<String, dynamic> json) => DetailedPost(
        post: json["post"] == null ? null : PostData.fromJson(json["post"]),
        comments: json["comments"] == null
            ? null
            : List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x))),
        isLike: json["is_like"] == null ? null : json["is_like"],
      );

  Map<String, dynamic> toJson() => {
        "post": post == null ? null : post!.toJson(),
        "comments": comments == null
            ? null
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "is_like": isLike == null ? null : isLike,
      };
}

class Comment {
  Comment({
    required this.id,
    this.userId,
    this.postId,
    this.comment,
    this.isLike,
    this.countLikes,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int id;
  int? userId;
  int? postId;
  String? comment;
  int? isLike;
  int? countLikes;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        postId: json["post_id"] == null ? null : json["post_id"],
        comment: json["comment"] == null ? null : json["comment"],
        isLike: json["is_like"] == null ? null : json["is_like"],
        countLikes: json["count_likes"] == null ? null : json["count_likes"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "post_id": postId == null ? null : postId,
        "comment": comment == null ? null : comment,
        "is_like": isLike == null ? null : isLike,
        "count_likes": countLikes == null ? null : countLikes,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "user": user == null ? null : user!.toJson(),
      };
}

class PostData {
  PostData({
    required this.id,
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
    this.posts,
  });

  int id;
  int? userId;
  String? thought;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic longitude;
  dynamic latitude;
  dynamic address;
  int? totalLikes;
  int? totalComments;
  User? user;
  List<Post>? posts;

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        thought: json["thought"] == null ? null : json["thought"],
        image: json["image"] == null ? null : json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        longitude: json["longitude"],
        latitude: json["latitude"],
        address: json["address"],
        totalLikes: json["total_likes"] == null ? null : json["total_likes"],
        totalComments:
            json["total_comments"] == null ? null : json["total_comments"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        posts: json["posts"] == null
            ? null
            : List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "thought": thought == null ? null : thought,
        "image": image == null ? null : image,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "longitude": longitude,
        "latitude": latitude,
        "address": address,
        "total_likes": totalLikes == null ? null : totalLikes,
        "total_comments": totalComments == null ? null : totalComments,
        "user": user == null ? null : user!.toJson(),
        "posts": posts == null
            ? null
            : List<dynamic>.from(posts!.map((x) => x.toJson())),
      };
}

// class Post {
//   Post({
//     required this.id,
//     this.userId,
//     this.postId,
//     this.media,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   int id;
//   int? userId;
//   int? postId;
//   String? media;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//         id: json["id"] == null ? null : json["id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         postId: json["post_id"] == null ? null : json["post_id"],
//         media: json["media"] == null ? null : json["media"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "post_id": postId == null ? null : postId,
//         "media": media == null ? null : media,
//         "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
//       };
// }

class User {
  User({
    required this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.role,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.address1,
    this.address2,
    this.zipCode,
    this.city,
    this.state,
    this.country,
    this.phoneNumber,
    this.phoneCode,
    this.avatar,
    this.loginType,
    this.socialProvider,
    this.socialId,
    this.socialAvatar,
    this.deviceToken,
    this.deviceType,
    this.longitude,
    this.latitude,
    this.notification,
    this.isAvailable,
    this.deletedAt,
    this.aboutUs,
    this.isUpdate,
    this.ratingAvg,
    this.isCustomer,
  });

  int id;
  String? name;
  dynamic firstName;
  dynamic lastName;
  String? userName;
  String? email;
  String? role;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? address1;
  String? address2;
  String? zipCode;
  String? city;
  dynamic state;
  dynamic country;
  int? phoneNumber;
  int? phoneCode;
  String? avatar;
  String? loginType;
  dynamic socialProvider;
  dynamic socialId;
  dynamic socialAvatar;
  dynamic deviceToken;
  dynamic deviceType;
  double? longitude;
  double? latitude;
  int? notification;
  int? isAvailable;
  dynamic deletedAt;
  dynamic aboutUs;
  int? isUpdate;
  String? ratingAvg;
  int? isCustomer;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userName: json["user_name"] == null ? null : json["user_name"],
        email: json["email"] == null ? null : json["email"],
        role: json["role"] == null ? null : json["role"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        address1: json["address1"] == null ? null : json["address1"],
        address2: json["address2"] == null ? null : json["address2"],
        zipCode: json["zip_code"] == null ? null : json["zip_code"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"],
        country: json["country"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        phoneCode: json["phone_code"] == null ? null : json["phone_code"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        loginType: json["login_type"] == null ? null : json["login_type"],
        socialProvider: json["social_provider"],
        socialId: json["social_id"],
        socialAvatar: json["social_avatar"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        notification:
            json["notification"] == null ? null : json["notification"],
        isAvailable: json["is_available"] == null ? null : json["is_available"],
        deletedAt: json["deleted_at"],
        aboutUs: json["about_us"],
        isUpdate: json["is_update"] == null ? null : json["is_update"],
        ratingAvg: json["rating_avg"] == null ? null : json["rating_avg"],
        isCustomer: json["is_customer"] == null ? null : json["is_customer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "first_name": firstName,
        "last_name": lastName,
        "user_name": userName == null ? null : userName,
        "email": email == null ? null : email,
        "role": role == null ? null : role,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "address1": address1 == null ? null : address1,
        "address2": address2 == null ? null : address2,
        "zip_code": zipCode == null ? null : zipCode,
        "city": city == null ? null : city,
        "state": state,
        "country": country,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "phone_code": phoneCode == null ? null : phoneCode,
        "avatar": avatar == null ? null : avatar,
        "login_type": loginType == null ? null : loginType,
        "social_provider": socialProvider,
        "social_id": socialId,
        "social_avatar": socialAvatar,
        "device_token": deviceToken,
        "device_type": deviceType,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "notification": notification == null ? null : notification,
        "is_available": isAvailable == null ? null : isAvailable,
        "deleted_at": deletedAt,
        "about_us": aboutUs,
        "is_update": isUpdate == null ? null : isUpdate,
        "rating_avg": ratingAvg == null ? null : ratingAvg,
        "is_customer": isCustomer == null ? null : isCustomer,
      };
}
