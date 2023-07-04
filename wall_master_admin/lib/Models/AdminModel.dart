// To parse this JSON data, do
//
//     final adminModel = adminModelFromMap(jsonString);

import 'dart:convert';

class AdminModel {
  String? message;
  bool? success;
  int? status;
  String? tokenType;
  String? accessToken;
  Data? data;

  AdminModel({
    this.message,
    this.success,
    this.status,
    this.tokenType,
    this.accessToken,
    this.data,
  });

  factory AdminModel.fromJson(String str) => AdminModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminModel.fromMap(Map<String, dynamic> json) => AdminModel(
    message: json["message"],
    success: json["success"],
    status: json["status"],
    tokenType: json["token_type"],
    accessToken: json["access_token"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "success": success,
    "status": status,
    "token_type": tokenType,
    "access_token": accessToken,
    "data": data?.toMap(),
  };
}

class Data {
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

  Data({
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

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
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



//AdminModel Failure

// To parse this JSON data, do
//
//     final adminModelFailure = adminModelFailureFromMap(jsonString);


class AdminModelFailure {
  String? message;
  bool? success;
  int? status;
  dynamic data;

  AdminModelFailure({
    this.message,
    this.success,
    this.status,
    this.data,
  });

  factory AdminModelFailure.fromJson(String str) => AdminModelFailure.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminModelFailure.fromMap(Map<String, dynamic> json) => AdminModelFailure(
    message: json["message"],
    success: json["success"],
    status: json["status"],
    data: json["data"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "success": success,
    "status": status,
    "data": data,
  };
}
