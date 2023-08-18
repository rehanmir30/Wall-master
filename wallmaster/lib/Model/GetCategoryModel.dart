// To parse this JSON data, do
//
//     final getCategoryModel = getCategoryModelFromMap(jsonString);

import 'dart:convert';

class GetCategoryModel {
  String? message;
  bool? success;
  int? status;
  List<Datum>? data;

  GetCategoryModel({
    this.message,
    this.success,
    this.status,
    this.data,
  });

  factory GetCategoryModel.fromJson(String str) => GetCategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetCategoryModel.fromMap(Map<String, dynamic> json) => GetCategoryModel(
    message: json["message"],
    success: json["success"],
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "success": success,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  int? id;
  String? name;
  String? image;
  String? imageName;
  int? priority;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.image,
    this.imageName,
    this.priority,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    imageName: json["image_name"],
    priority: json["priority"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "image": image,
    "image_name": imageName,
    "priority": priority,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
