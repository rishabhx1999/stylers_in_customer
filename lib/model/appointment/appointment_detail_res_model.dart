// To parse this JSON data, do
//
//     final appointmentDetailResModel = appointmentDetailResModelFromJson(jsonString);

import 'dart:convert';

import '../calendar/calendar_appointments_res_model.dart';

AppointmentDetailResModel appointmentDetailResModelFromJson(String str) =>
    AppointmentDetailResModel.fromJson(json.decode(str));

String appointmentDetailResModelToJson(AppointmentDetailResModel data) =>
    json.encode(data.toJson());

class AppointmentDetailResModel {
  AppointmentDetailResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  AppointmentDetail? data;

  factory AppointmentDetailResModel.fromJson(Map<String, dynamic> json) =>
      AppointmentDetailResModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : AppointmentDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class AppointmentDetail {
  AppointmentDetail({
    required this.id,
    this.userId,
    this.serviceId,
    this.subServiceId,
    this.note,
    this.day,
    this.timeSlotId,
    this.remindMe,
    this.remindMeTime,
    this.bookedUserId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.longitude,
    this.latitude,
    this.address1,
    this.address2,
    this.zip,
    this.date,
    this.serviceName,
    this.subServiceName,
    this.serviceRate,
    this.bookedUserName,
    this.bookedUserRole,
    this.bookedUserAvatar,
    this.timeslot,
  });

  int id;
  int? userId;
  int? serviceId;
  int? subServiceId;
  String? note;
  int? day;
  int? timeSlotId;
  int? remindMe;
  int? remindMeTime;
  int? bookedUserId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? longitude;
  double? latitude;
  String? address1;
  String? address2;
  String? zip;
  DateTime? date;
  String? serviceName;
  String? subServiceName;
  String? serviceRate;
  String? bookedUserName;
  String? bookedUserRole;
  String? bookedUserAvatar;
  Timeslot? timeslot;

  factory AppointmentDetail.fromJson(Map<String, dynamic> json) =>
      AppointmentDetail(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        serviceId: json["service_id"] == null ? null : json["service_id"],
        subServiceId:
            json["sub_service_id"] == null ? null : json["sub_service_id"],
        note: json["note"] == null ? null : json["note"],
        day: json["day"] == null ? null : json["day"],
        timeSlotId: json["time_slot_id"] == null ? null : json["time_slot_id"],
        remindMe: json["remind_me"] == null ? null : json["remind_me"],
        remindMeTime:
            json["remind_me_time"] == null ? null : json["remind_me_time"],
        bookedUserId:
            json["booked_user_id"] == null ? null : json["booked_user_id"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        address1: json["address1"] == null ? null : json["address1"],
        address2: json["address2"] == null ? null : json["address2"],
        zip: json["zip"] == null ? null : json["zip"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        serviceName: json["service_name"] == null ? null : json["service_name"],
        subServiceName:
            json["sub_service_name"] == null ? null : json["sub_service_name"],
        serviceRate: json["service_rate"] == null ? null : json["service_rate"],
        bookedUserName:
            json["booked_user_name"] == null ? null : json["booked_user_name"],
        bookedUserRole:
            json["booked_user_role"] == null ? null : json["booked_user_role"],
        bookedUserAvatar: json["booked_user_avatar"] == null
            ? null
            : json["booked_user_avatar"],
        timeslot: json["timeslot"] == null
            ? null
            : Timeslot.fromJson(json["timeslot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "service_id": serviceId == null ? null : serviceId,
        "sub_service_id": subServiceId == null ? null : subServiceId,
        "note": note == null ? null : note,
        "day": day == null ? null : day,
        "time_slot_id": timeSlotId == null ? null : timeSlotId,
        "remind_me": remindMe == null ? null : remindMe,
        "remind_me_time": remindMeTime == null ? null : remindMeTime,
        "booked_user_id": bookedUserId == null ? null : bookedUserId,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "address1": address1 == null ? null : address1,
        "address2": address2 == null ? null : address2,
        "zip": zip == null ? null : zip,
        "date": date == null ? null : date!.toIso8601String(),
        "service_name": serviceName == null ? null : serviceName,
        "sub_service_name": subServiceName == null ? null : subServiceName,
        "service_rate": serviceRate == null ? null : serviceRate,
        "booked_user_name": bookedUserName == null ? null : bookedUserName,
        "booked_user_role": bookedUserRole == null ? null : bookedUserRole,
        "booked_user_avatar":
            bookedUserAvatar == null ? null : bookedUserAvatar,
        "timeslot": timeslot == null ? null : timeslot!.toJson(),
      };
}
