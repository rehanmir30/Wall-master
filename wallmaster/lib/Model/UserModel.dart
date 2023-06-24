// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

class UserModel {
  String? message;
  bool? success;
  int? status;
  String? tokenType;
  String? accessToken;
  Data? data;

  UserModel({
    this.message,
    this.success,
    this.status,
    this.tokenType,
    this.accessToken,
    this.data,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
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
  int? isPremimum;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.isPremimum,
    this.image,
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
    isPremimum: json["is_premimum"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "is_premimum": isPremimum,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}



//For Login Failure Response

// To parse this JSON data, do
//
//     final userModelFailure = userModelFailureFromMap(jsonString);


class UserModelFailure {
  String? message;
  bool? success;
  int? status;

  UserModelFailure({
    this.message,
    this.success,
    this.status,
  });

  factory UserModelFailure.fromJson(String str) => UserModelFailure.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModelFailure.fromMap(Map<String, dynamic> json) => UserModelFailure(
    message: json["message"],
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "success": success,
    "status": status,
  };
}
