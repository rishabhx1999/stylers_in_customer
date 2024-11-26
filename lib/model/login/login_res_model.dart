// To parse this JSON data, do
//
//     final loginResModel = loginResModelFromJson(jsonString);

import 'dart:convert';

LoginResModel loginResModelFromJson(String str) => LoginResModel.fromJson(json.decode(str));

String loginResModelToJson(LoginResModel data) => json.encode(data.toJson());

class LoginResModel {
  LoginResModel({
   required this.success,
    required this.message,
    this.user,
    this.status,
  });

  bool success;
  String message;
  User? user;
  int? status;

  factory LoginResModel.fromJson(Map<String, dynamic> json) => LoginResModel(
    success:  json["success"],
    message: json["message"],
    user: json["data"] == null ? null : User.fromJson(json["data"]),
    status:  json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message":  message,
    "data": user == null ? null : user!.toJson(),
    "status":  status,
  };
}

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
    this.token,
    this.ratingOne,
    this.ratingTwo,
    this.ratingThree,
    this.ratingFour,
    this.ratingFive,
    this.ratingAverage,
    this.rate,
  });

  int id;
  String? name;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? role;
  String? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? address1;
  String? address2;
  String? zipCode;
  String? city;
  String? state;
  String? country;
  int? phoneNumber;
  int? phoneCode;
  String? avatar;
  String? loginType;
  String? socialProvider;
  String? socialId;
  String? socialAvatar;
  String? deviceToken;
  String? deviceType;
  dynamic longitude;
  dynamic latitude;
  int? notification;
  int? isAvailable;
  String? deletedAt;
  String? aboutUs;
  int? isUpdate;
  String? ratingAvg;
  int? isCustomer;
  String? token;
//extra params for stylists and shopkeeper
  int? ratingOne;
  int? ratingTwo;
  int? ratingThree;
  int? ratingFour;
  int? ratingFive;
  dynamic ratingAverage;
  String? rate;


  factory User.fromJson(Map<String, dynamic> json) => User(
    id:  json["id"],
    name: json["name"],
    firstName:  json["first_name"],
    lastName: json["last_name"],
    userName:  json["user_name"],
    email:  json["email"],
    role: json["role"],
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
    phoneCode:  json["phone_code"],
    avatar:  json["avatar"],
    loginType:  json["login_type"],
    socialProvider: json["social_provider"],
    socialId: json["social_id"],
    socialAvatar: json["social_avatar"],
    deviceToken: json["device_token"],
    deviceType: json["device_type"],
    longitude:  json["longitude"],
    latitude:  json["latitude"],
    notification:  json["notification"],
    isAvailable:  json["is_available"],
    deletedAt: json["deleted_at"],
    aboutUs: json["about_us"],
    isUpdate:  json["is_update"],
    ratingAvg:  json["rating_avg"],
    isCustomer:  json["is_customer"],
    token:  json["token"],
    ratingOne:  json["rating_one"],
    ratingTwo:  json["rating_two"],
    ratingThree: json["rating_three"],
    ratingFour:  json["rating_four"],
    ratingFive:  json["rating_five"],
    ratingAverage:  json["rating_average"],
    rate:  json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "id":  id,
    "name":  name,
    "first_name":  firstName,
    "last_name":  lastName,
    "user_name":  userName,
    "email":  email,
    "role":  role,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "address1": address1,
    "address2": address2,
    "zip_code": zipCode,
    "city": city,
    "state": state,
    "country": country,
    "phone_number":  phoneNumber,
    "phone_code": phoneCode,
    "avatar":  avatar,
    "login_type":  loginType,
    "social_provider": socialProvider,
    "social_id": socialId,
    "social_avatar": socialAvatar,
    "device_token": deviceToken,
    "device_type": deviceType,
    "longitude": longitude,
    "latitude":  latitude,
    "notification":  notification,
    "is_available":  isAvailable,
    "deleted_at": deletedAt,
    "about_us": aboutUs,
    "is_update":  isUpdate,
    "rating_avg":  ratingAvg,
    "is_customer":  isCustomer,
    "token":  token,
    "rating_one":  ratingOne,
    "rating_two":  ratingTwo,
    "rating_three": ratingThree,
    "rating_four": ratingFour,
    "rating_five":  ratingFive,
    "rating_average":  ratingAverage,
    "rate":  rate,
  };

}
