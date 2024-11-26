// To parse this JSON data, do
//
//     final signupResModel = signupResModelFromJson(jsonString);

import 'dart:convert';

SignupResModel signupResModelFromJson(String str) => SignupResModel.fromJson(json.decode(str));

String signupResModelToJson(SignupResModel data) => json.encode(data.toJson());

class SignupResModel {
  SignupResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  SignupResData? data;

  factory SignupResModel.fromJson(Map<String, dynamic> json) => SignupResModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : SignupResData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? null : data!.toJson(),
  };
}

class SignupResData {
  SignupResData({
    this.firstName,
    this.lastName,
    this.name,
    this.userName,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.role,
    this.longitude,
    this.latitude,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token,
  });

  String? firstName;
  String? lastName;
  String? name;
  String? userName;
  String? email;
  String? phoneCode;
  String? phoneNumber;
  String? role;
  String? longitude;
  String? latitude;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? token;

  factory SignupResData.fromJson(Map<String, dynamic> json) => SignupResData(
    firstName: json["first_name"],
    lastName: json["last_name"],
    name: json["name"],
    userName: json["user_name"],
    email: json["email"],
    phoneCode: json["phone_code"],
    phoneNumber: json["phone_number"],
    role: json["role"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "name": name,
    "user_name": userName,
    "email": email,
    "phone_code": phoneCode,
    "phone_number": phoneNumber,
    "role": role,
    "longitude": longitude,
    "latitude": latitude,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "id": id,
    "token": token,
  };
}
