// To parse this JSON data, do
//
//     final createCommentResModel = createCommentResModelFromJson(jsonString);

import 'dart:convert';

import 'package:stylers_in_customer/model/detailed_post/detailed_post_res_model.dart';

CreateCommentResModel createCommentResModelFromJson(String str) =>
    CreateCommentResModel.fromJson(json.decode(str));

String createCommentResModelToJson(CreateCommentResModel data) =>
    json.encode(data.toJson());

class CreateCommentResModel {
  CreateCommentResModel({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  Comment? data;

  factory CreateCommentResModel.fromJson(Map<String, dynamic> json) =>
      CreateCommentResModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Comment.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

// class Data {
//   Data({
//     this.userId,
//     this.postId,
//     this.comment,
//     this.updatedAt,
//     this.createdAt,
//     required this.id,
//   });
//
//   int? userId;
//   int? postId;
//   String? comment;
//   DateTime? updatedAt;
//   DateTime? createdAt;
//   int id;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     userId: json["user_id"] == null ? null : json["user_id"],
//     postId: json["post_id"] == null ? null : json["post_id"],
//     comment: json["comment"] == null ? null : json["comment"],
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     id: json["id"] == null ? null : json["id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "user_id": userId == null ? null : userId,
//     "post_id": postId == null ? null : postId,
//     "comment": comment == null ? null : comment,
//     "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
//     "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
//     "id": id == null ? null : id,
//   };
// }
