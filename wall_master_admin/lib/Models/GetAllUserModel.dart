// To parse this JSON data, do
//
//     final getAllUserModel = getAllUserModelFromMap(jsonString);

import 'dart:convert';

class GetAllUserModel {
  String? message;
  bool? success;
  int? status;
  List<UserData>? data;

  GetAllUserModel({
    this.message,
    this.success,
    this.status,
    this.data,
  });

  factory GetAllUserModel.fromJson(String str) => GetAllUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllUserModel.fromMap(Map<String, dynamic> json) => GetAllUserModel(
    message: json["message"],
    success: json["success"],
    status: json["status"],
    data: json["data"] == null ? [] : List<UserData>.from(json["data"]!.map((x) => UserData.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "success": success,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class UserData {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? role;
  int? isPremimum;
  dynamic image;
  dynamic imageName;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserData({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.isPremimum,
    this.image,
    this.imageName,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    role: json["role"],
    isPremimum: json["is_premimum"],
    image: json["image"],
    imageName: json["image_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "role": role,
    "is_premimum": isPremimum,
    "image": image,
    "image_name": imageName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
