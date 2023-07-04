// To parse this JSON data, do
//
//     final likedWallpaperModel = likedWallpaperModelFromMap(jsonString);

import 'dart:convert';

class LikedWallpaperModel {
  String? message;
  bool? success;
  int? status;
  List<LikeProductData>? data;

  LikedWallpaperModel({
    this.message,
    this.success,
    this.status,
    this.data,
  });

  factory LikedWallpaperModel.fromJson(String str) => LikedWallpaperModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LikedWallpaperModel.fromMap(Map<String, dynamic> json) => LikedWallpaperModel(
    message: json["message"],
    success: json["success"],
    status: json["status"],
    data: json["data"] == null ? [] : List<LikeProductData>.from(json["data"]!.map((x) => LikeProductData.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "success": success,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class LikeProductData {
  int? id;
  int? categoryId;
  String? name;
  String? image;
  String? imageName;
  int? forPremium;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  LikeProductData({
    this.id,
    this.categoryId,
    this.name,
    this.image,
    this.imageName,
    this.forPremium,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory LikeProductData.fromJson(String str) => LikeProductData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LikeProductData.fromMap(Map<String, dynamic> json) => LikeProductData(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    image: json["image"],
    imageName: json["image_name"],
    forPremium: json["for_premium"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : Pivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "image": image,
    "image_name": imageName,
    "for_premium": forPremium,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "pivot": pivot?.toMap(),
  };
}

class Pivot {
  int? userId;
  int? productId;

  Pivot({
    this.userId,
    this.productId,
  });

  factory Pivot.fromJson(String str) => Pivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
    userId: json["user_id"],
    productId: json["product_id"],
  );

  Map<String, dynamic> toMap() => {
    "user_id": userId,
    "product_id": productId,
  };
}
