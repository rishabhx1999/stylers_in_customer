// To parse this JSON data, do
//
//     final socialLoginResModel = socialLoginResModelFromJson(jsonString);

import 'dart:convert';

SocialLoginResModel socialLoginResModelFromJson(String str) => SocialLoginResModel.fromJson(json.decode(str));

String socialLoginResModelToJson(SocialLoginResModel data) => json.encode(data.toJson());

class SocialLoginResModel {
  SocialLoginResModel({
    required this.success,
    required this.message,
    this.data,
    this.status,
  });

  bool success;
  String message;
  SocialLoginResData? data;
  int? status;

  factory SocialLoginResModel.fromJson(Map<String, dynamic> json) => SocialLoginResModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : SocialLoginResData.fromJson(json["data"]),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
    "status": status == null ? null : status,
  };
}

class SocialLoginResData {
  SocialLoginResData({
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
    this.stripeCustId,
    this.token,
  });

  int id;
  String? name;
  dynamic firstName;
  dynamic lastName;
  dynamic userName;
  String? email;
  String? role;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic address1;
  dynamic address2;
  dynamic zipCode;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic phoneNumber;
  dynamic phoneCode;
  String? avatar;
  String? loginType;
  String? socialProvider;
  String? socialId;
  dynamic socialAvatar;
  dynamic deviceToken;
  dynamic deviceType;
  dynamic longitude;
  dynamic latitude;
  int? notification;
  int? isAvailable;
  dynamic deletedAt;
  dynamic aboutUs;
  int? isUpdate;
  String? ratingAvg;
  int? isCustomer;
  dynamic stripeCustId;
  String? token;

  factory SocialLoginResData.fromJson(Map<String, dynamic> json) => SocialLoginResData(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    userName: json["user_name"],
    email: json["email"] == null ? null : json["email"],
    role: json["role"] == null ? null : json["role"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    address1: json["address1"],
    address2: json["address2"],
    zipCode: json["zip_code"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    phoneNumber: json["phone_number"],
    phoneCode: json["phone_code"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    loginType: json["login_type"] == null ? null : json["login_type"],
    socialProvider: json["social_provider"] == null ? null : json["social_provider"],
    socialId: json["social_id"] == null ? null : json["social_id"],
    socialAvatar: json["social_avatar"],
    deviceToken: json["device_token"],
    deviceType: json["device_type"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    notification: json["notification"] == null ? null : json["notification"],
    isAvailable: json["is_available"] == null ? null : json["is_available"],
    deletedAt: json["deleted_at"],
    aboutUs: json["about_us"],
    isUpdate: json["is_update"] == null ? null : json["is_update"],
    ratingAvg: json["rating_avg"] == null ? null : json["rating_avg"],
    isCustomer: json["is_customer"] == null ? null : json["is_customer"],
    stripeCustId: json["stripe_cust_id"],
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "first_name": firstName,
    "last_name": lastName,
    "user_name": userName,
    "email": email == null ? null : email,
    "role": role == null ? null : role,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "address1": address1,
    "address2": address2,
    "zip_code": zipCode,
    "city": city,
    "state": state,
    "country": country,
    "phone_number": phoneNumber,
    "phone_code": phoneCode,
    "avatar": avatar == null ? null : avatar,
    "login_type": loginType == null ? null : loginType,
    "social_provider": socialProvider == null ? null : socialProvider,
    "social_id": socialId == null ? null : socialId,
    "social_avatar": socialAvatar,
    "device_token": deviceToken,
    "device_type": deviceType,
    "longitude": longitude,
    "latitude": latitude,
    "notification": notification == null ? null : notification,
    "is_available": isAvailable == null ? null : isAvailable,
    "deleted_at": deletedAt,
    "about_us": aboutUs,
    "is_update": isUpdate == null ? null : isUpdate,
    "rating_avg": ratingAvg == null ? null : ratingAvg,
    "is_customer": isCustomer == null ? null : isCustomer,
    "stripe_cust_id": stripeCustId,
    "token": token == null ? null : token,
  };
}
