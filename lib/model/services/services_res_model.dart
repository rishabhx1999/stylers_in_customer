// To parse this JSON data, do
//
//     final servicesResModel = servicesResModelFromJson(jsonString);

import 'dart:convert';

ServicesResModel servicesResModelFromJson(String str) => ServicesResModel.fromJson(json.decode(str));

String servicesResModelToJson(ServicesResModel data) => json.encode(data.toJson());

class ServicesResModel {
  ServicesResModel({
   required this.success,
    required this.message,
    this.services,
  });

  bool success;
  String message;
  List<Service>? services;

  factory ServicesResModel.fromJson(Map<String, dynamic> json) => ServicesResModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    services: json["data"] == null ? null : List<Service>.from(json["data"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success":  success,
    "message":  message,
    "data": services == null ? null : List<dynamic>.from(services!.map((x) => x.toJson())),
  };
}

class Service {
  Service({
    required this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String? name;
  String? image;
  dynamic createdAt;
  dynamic updatedAt;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id:  json["id"],
    name: json["name"],
    image:  json["image"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name":  name,
    "image":  image,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
