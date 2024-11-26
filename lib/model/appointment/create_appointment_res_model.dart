// To parse this JSON data, do
//
//     final createAppointmentResModel = createAppointmentResModelFromJson(jsonString);

import 'dart:convert';

CreateAppointmentResModel createAppointmentResModelFromJson(String str) => CreateAppointmentResModel.fromJson(json.decode(str));

String createAppointmentResModelToJson(CreateAppointmentResModel data) => json.encode(data.toJson());

class CreateAppointmentResModel {
  CreateAppointmentResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  CreateAppointmentResponse? data;

  factory CreateAppointmentResModel.fromJson(Map<String, dynamic> json) => CreateAppointmentResModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : CreateAppointmentResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class CreateAppointmentResponse {
  CreateAppointmentResponse({
    this.userId,
    this.serviceId,
    this.subServiceId,
    this.note,
    this.date,
    this.day,
    this.timeSlotId,
    this.remindMe,
    this.remindMeTime,
    this.serviceRateId,
    this.bookedUserId,
    this.longitude,
    this.latitude,
    this.address1,
    this.address2,
    this.zip,
    this.updatedAt,
    this.createdAt,
    required this.id,
  });

  int? userId;
  int? serviceId;
  int? subServiceId;
  String? note;
  DateTime? date;
  int? day;
  int? timeSlotId;
  int? remindMe;
  int? remindMeTime;
  int? serviceRateId;
  int? bookedUserId;
  double? longitude;
  double? latitude;
  String? address1;
  String? address2;
  String? zip;
  DateTime? updatedAt;
  DateTime? createdAt;
  int id;

  factory CreateAppointmentResponse.fromJson(Map<String, dynamic> json) => CreateAppointmentResponse(
    userId: json["user_id"] == null ? null : json["user_id"],
    serviceId: json["service_id"] == null ? null : json["service_id"],
    subServiceId: json["sub_service_id"] == null ? null : json["sub_service_id"],
    note: json["note"] == null ? null : json["note"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"] == null ? null : json["day"],
    timeSlotId: json["time_slot_id"] == null ? null : json["time_slot_id"],
    remindMe: json["remind_me"] == null ? null : json["remind_me"],
    remindMeTime: json["remind_me_time"] == null ? null : json["remind_me_time"],
    serviceRateId: json["service_rate_id"] == null ? null : json["service_rate_id"],
    bookedUserId: json["booked_user_id"] == null ? null : json["booked_user_id"],
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    address1: json["address1"] == null ? null :  json["address1"],
    address2: json["address2"] == null ? null : json["address2"],
    zip: json["zip"] == null ? null : json["zip"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "service_id": serviceId == null ? null : serviceId,
    "sub_service_id": subServiceId == null ? null : subServiceId,
    "note": note == null ? null : note,
    "date": date == null ? null : date!.toIso8601String(),
    "day": day == null ? null : day,
    "time_slot_id": timeSlotId == null ? null : timeSlotId,
    "remind_me": remindMe == null ? null : remindMe,
    "remind_me_time": remindMeTime == null ? null : remindMeTime,
    "service_rate_id": serviceRateId == null ? null : serviceRateId,
    "booked_user_id": bookedUserId == null ? null : bookedUserId,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
    "address1": address1 == null ? null : address1,
    "address2": address2 == null ? null : address2,
    "zip": zip == null ? null : zip,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "id": id == null ? null : id,
  };
}
