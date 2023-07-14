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
  String? role;
  int? isPremium;
  dynamic image;
  dynamic imageName;
  dynamic socialUuid;
  String? language;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic subscribeDate;

  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.isPremium,
    this.image,
    this.imageName,
    this.socialUuid,
    this.language,
    this.createdAt,
    this.updatedAt,
    this.subscribeDate,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    role: json["role"],
    isPremium: json["is_premium"],
    image: json["image"],
    imageName: json["image_name"],
    socialUuid: json["social_uuid"],
    language: json["language"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subscribeDate: json["subscribe_date"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "role": role,
    "is_premium": isPremium,
    "image": image,
    "image_name": imageName,
    "social_uuid": socialUuid,
    "language": language,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "subscribe_date": subscribeDate,
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
