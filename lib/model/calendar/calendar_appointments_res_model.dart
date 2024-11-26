// To parse this JSON data, do
//
//     final calendarAppointmentsResModel = calendarAppointmentsResModelFromJson(jsonString);

import 'dart:convert';

CalendarAppointmentsResModel calendarAppointmentsResModelFromJson(String str) =>
    CalendarAppointmentsResModel.fromJson(json.decode(str));

String calendarAppointmentsResModelToJson(CalendarAppointmentsResModel data) =>
    json.encode(data.toJson());

class CalendarAppointmentsResModel {
  CalendarAppointmentsResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  List<List<CalendarAppointment>>? data;

  factory CalendarAppointmentsResModel.fromJson(Map<String, dynamic> json) =>
      CalendarAppointmentsResModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<List<CalendarAppointment>>.from(json["data"].map((x) =>
                List<CalendarAppointment>.from(
                    x.map((x) => CalendarAppointment.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(
                data!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class CalendarAppointment {
  CalendarAppointment({
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
    this.bookedUser,
    this.service,
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
  BookedUser? bookedUser;
  Service? service;
  Timeslot? timeslot;

  factory CalendarAppointment.fromJson(Map<String, dynamic> json) =>
      CalendarAppointment(
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
        bookedUser: json["booked_user"] == null
            ? null
            : BookedUser.fromJson(json["booked_user"]),
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
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
        "booked_user": bookedUser == null ? null : bookedUser!.toJson(),
        "service": service == null ? null : service!.toJson(),
        "timeslot": timeslot == null ? null : timeslot!.toJson(),
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

class Timeslot {
  Timeslot({
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

  factory Timeslot.fromJson(Map<String, dynamic> json) => Timeslot(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        day: json["day"] == null ? null : json["day"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        isFreeTimeSlot: json["is_free_time_slot"] == null
            ? null
            : json["is_free_time_slot"],
        setAvailabilityId: json["set_availability_id"] == null
            ? null
            : json["set_availability_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "day": day == null ? null : day,
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
        "is_free_time_slot": isFreeTimeSlot == null ? null : isFreeTimeSlot,
        "set_availability_id":
            setAvailabilityId == null ? null : setAvailabilityId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class BookedUser {
  BookedUser({
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
    this.appNotification,
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
  String? address2;
  String? zipCode;
  String? city;
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
  dynamic aboutUs;
  int? isUpdate;
  String? ratingAvg;
  int? isCustomer;
  dynamic stripeCustId;
  int? appNotification;

  factory BookedUser.fromJson(Map<String, dynamic> json) => BookedUser(
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
        address2: json["address2"] == null ? null : json["address2"],
        zipCode: json["zip_code"] == null ? null : json["zip_code"],
        city: json["city"] == null ? null : json["city"],
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
        aboutUs: json["about_us"],
        isUpdate: json["is_update"] == null ? null : json["is_update"],
        ratingAvg: json["rating_avg"] == null ? null : json["rating_avg"],
        isCustomer: json["is_customer"] == null ? null : json["is_customer"],
        stripeCustId: json["stripe_cust_id"],
        appNotification:
            json["app_notification"] == null ? null : json["app_notification"],
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
        "address2": address2 == null ? null : address2,
        "zip_code": zipCode == null ? null : zipCode,
        "city": city == null ? null : city,
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
        "about_us": aboutUs,
        "is_update": isUpdate == null ? null : isUpdate,
        "rating_avg": ratingAvg == null ? null : ratingAvg,
        "is_customer": isCustomer == null ? null : isCustomer,
        "stripe_cust_id": stripeCustId,
        "app_notification": appNotification == null ? null : appNotification,
      };
}
