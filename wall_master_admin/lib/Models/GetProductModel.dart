// To parse this JSON data, do
//
//     final getProductModel = getProductModelFromMap(jsonString);

import 'dart:convert';

class GetProductModel {
  String? message;
  bool? success;
  int? status;
  List<ProductData>? data;

  GetProductModel({
    this.message,
    this.success,
    this.status,
    this.data,
  });

  factory GetProductModel.fromJson(String str) => GetProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetProductModel.fromMap(Map<String, dynamic> json) => GetProductModel(
    message: json["message"],
    success: json["success"],
    status: json["status"],
    data: json["data"] == null ? [] : List<ProductData>.from(json["data"]!.map((x) => ProductData.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "success": success,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class ProductData {
  int? id;
  int? categoryId;
  String? name;
  String? image;
  String? imageName;
  int? forPremium;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? tags;

  ProductData({
    this.id,
    this.categoryId,
    this.name,
    this.image,
    this.imageName,
    this.forPremium,
    this.createdAt,
    this.updatedAt,
    this.tags,
  });

  factory ProductData.fromJson(String str) => ProductData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductData.fromMap(Map<String, dynamic> json) => ProductData(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    image: json["image"],
    imageName: json["image_name"],
    forPremium: json["for_premium"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
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
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
  };
}
