// To parse this JSON data, do
//
//     final providerSubServicesResModel = providerSubServicesResModelFromJson(jsonString);

import 'dart:convert';

ProviderSubServicesResModel providerSubServicesResModelFromJson(String str) =>
    ProviderSubServicesResModel.fromJson(json.decode(str));

String providerSubServicesResModelToJson(ProviderSubServicesResModel data) =>
    json.encode(data.toJson());

class ProviderSubServicesResModel {
  ProviderSubServicesResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  List<ProviderSubService>? data;

  factory ProviderSubServicesResModel.fromJson(Map<String, dynamic> json) =>
      ProviderSubServicesResModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<ProviderSubService>.from(
                json["data"].map((x) => ProviderSubService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProviderSubService {
  ProviderSubService({
    required this.id,
    this.serviceId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.serviceRate,
  });

  int id;
  int? serviceId;
  String? name;
  dynamic createdAt;
  dynamic updatedAt;
  String? serviceRate;

  factory ProviderSubService.fromJson(Map<String, dynamic> json) =>
      ProviderSubService(
        id: json["id"] == null ? null : json["id"],
        serviceId: json["service_id"] == null ? null : json["service_id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        serviceRate: json["service_rate"] == null ? null : json["service_rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "service_id": serviceId == null ? null : serviceId,
        "name": name == null ? null : name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "service_rate": serviceRate == null ? null : serviceRate,
      };
}
