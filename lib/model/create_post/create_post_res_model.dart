// To parse this JSON data, do
//
//     final createPostResModel = createPostResModelFromJson(jsonString);

import 'dart:convert';

CreatePostResModel createPostResModelFromJson(String str) => CreatePostResModel.fromJson(json.decode(str));

String createPostResModelToJson(CreatePostResModel data) => json.encode(data.toJson());

class CreatePostResModel {
  CreatePostResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  CreatePostResponse? data;

  factory CreatePostResModel.fromJson(Map<String, dynamic> json) => CreatePostResModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : CreatePostResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class CreatePostResponse {
  CreatePostResponse({
    this.userId,
    this.thought,
    this.image,
    this.updatedAt,
    this.createdAt,
    required this.id,
  });

  int? userId;
  String? thought;
  String? image;
  DateTime? updatedAt;
  DateTime? createdAt;
  int id;

  factory CreatePostResponse.fromJson(Map<String, dynamic> json) => CreatePostResponse(
    userId: json["user_id"] == null ? null : json["user_id"],
    thought: json["thought"] == null ? null : json["thought"],
    image: json["image"] == null ? null : json["image"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "thought": thought == null ? null : thought,
    "image": image == null ? null : image,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "id": id == null ? null : id,
  };
}
