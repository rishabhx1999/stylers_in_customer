// To parse this JSON data, do
//
//     final providerServicesResModel = providerServicesResModelFromJson(jsonString);

import 'dart:convert';

ProviderServicesResModel providerServicesResModelFromJson(String str) =>
    ProviderServicesResModel.fromJson(json.decode(str));

String providerServicesResModelToJson(ProviderServicesResModel data) =>
    json.encode(data.toJson());

class ProviderServicesResModel {
  ProviderServicesResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  List<ProviderService>? data;

  factory ProviderServicesResModel.fromJson(Map<String, dynamic> json) =>
      ProviderServicesResModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<ProviderService>.from(
                json["data"].map((x) => ProviderService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProviderService {
  ProviderService({
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

  factory ProviderService.fromJson(Map<String, dynamic> json) =>
      ProviderService(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
