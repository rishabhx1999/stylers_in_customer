// To parse this JSON data, do
//
//     final editProfileResModel = editProfileResModelFromJson(jsonString);

import 'dart:convert';

EditProfileResModel editProfileResModelFromJson(String str) =>
    EditProfileResModel.fromJson(json.decode(str));

String editProfileResModelToJson(EditProfileResModel data) =>
    json.encode(data.toJson());

class EditProfileResModel {
  EditProfileResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  EditProfileResponse? data;

  factory EditProfileResModel.fromJson(Map<String, dynamic> json) =>
      EditProfileResModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : EditProfileResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class EditProfileResponse {
  EditProfileResponse({
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
  });

  int id;
  String? name;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? role;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? address1;
  dynamic address2;
  dynamic zipCode;
  dynamic city;
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
  String? aboutUs;
  int? isUpdate;
  String? ratingAvg;
  int? isCustomer;
  dynamic stripeCustId;

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) =>
      EditProfileResponse(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
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
        address2: json["address2"],
        zipCode: json["zip_code"],
        city: json["city"],
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
        aboutUs: json["about_us"] == null ? null : json["about_us"],
        isUpdate: json["is_update"] == null ? null : json["is_update"],
        ratingAvg: json["rating_avg"] == null ? null : json["rating_avg"],
        isCustomer: json["is_customer"] == null ? null : json["is_customer"],
        stripeCustId: json["stripe_cust_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "user_name": userName == null ? null : userName,
        "email": email == null ? null : email,
        "role": role == null ? null : role,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "address1": address1 == null ? null : address1,
        "address2": address2,
        "zip_code": zipCode,
        "city": city,
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
        "about_us": aboutUs == null ? null : aboutUs,
        "is_update": isUpdate == null ? null : isUpdate,
        "rating_avg": ratingAvg == null ? null : ratingAvg,
        "is_customer": isCustomer == null ? null : isCustomer,
        "stripe_cust_id": stripeCustId,
      };
}
