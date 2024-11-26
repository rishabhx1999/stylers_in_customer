// To parse this JSON data, do
//
//     final bookingFreeTimeSlotsResModel = bookingFreeTimeSlotsResModelFromJson(jsonString);

import 'dart:convert';

BookingFreeTimeSlotsResModel bookingFreeTimeSlotsResModelFromJson(String str) => BookingFreeTimeSlotsResModel.fromJson(json.decode(str));

String bookingFreeTimeSlotsResModelToJson(BookingFreeTimeSlotsResModel data) => json.encode(data.toJson());

class BookingFreeTimeSlotsResModel {
  BookingFreeTimeSlotsResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  List<BookingFreeTimeSlot>? data;

  factory BookingFreeTimeSlotsResModel.fromJson(Map<String, dynamic> json) => BookingFreeTimeSlotsResModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<BookingFreeTimeSlot>.from(json["data"].map((x) => BookingFreeTimeSlot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BookingFreeTimeSlot {
  BookingFreeTimeSlot({
    required this.id,
    this.userId,
    this.day,
    this.startTime,
    this.endTime,
    this.isFreeTimeSlot,
    this.setAvailabilityId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int? userId;
  int? day;
  String? startTime;
  String? endTime;
  int? isFreeTimeSlot;
  int? setAvailabilityId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory BookingFreeTimeSlot.fromJson(Map<String, dynamic> json) => BookingFreeTimeSlot(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    day: json["day"] == null ? null : json["day"],
    startTime: json["start_time"] == null ? null : json["start_time"],
    endTime: json["end_time"] == null ? null : json["end_time"],
    isFreeTimeSlot: json["is_free_time_slot"] == null ? null : json["is_free_time_slot"],
    setAvailabilityId: json["set_availability_id"] == null ? null : json["set_availability_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "day": day == null ? null : day,
    "start_time": startTime == null ? null : startTime,
    "end_time": endTime == null ? null : endTime,
    "is_free_time_slot": isFreeTimeSlot == null ? null : isFreeTimeSlot,
    "set_availability_id": setAvailabilityId == null ? null : setAvailabilityId,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
