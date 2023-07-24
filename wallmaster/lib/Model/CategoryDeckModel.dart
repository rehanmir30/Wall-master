import 'dart:convert';

import 'package:wallmaster/Model/GetProductModel.dart';


class CategoryDeckModel{

  int? id;
  String? name;
  String? image;
  String? imageName;
  List<ProductData>? wallpaperdata;

  CategoryDeckModel({
    this.id,
    this.name,
    this.image,
    this.imageName,
    this.wallpaperdata,
  });


  factory CategoryDeckModel.fromJson(String str) => CategoryDeckModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryDeckModel.fromMap(Map<String, dynamic> json) => CategoryDeckModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    imageName: json["image_name"],
    wallpaperdata: json["data"] == null ? [] : List<ProductData>.from(json["data"]!.map((x) => WallpaperData.fromMap(x))),

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "image": image,
    "image_name": imageName,
    "data": wallpaperdata == null ? [] : List<dynamic>.from(wallpaperdata!.map((x) => x.toMap())),
  };
}


class WallpaperData {
  int? id;
  int? categoryId;
  String? name;
  String? image;
  String? imageName;
  int? forPremium;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? tags;

  WallpaperData({
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

  factory WallpaperData.fromJson(String str) => WallpaperData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WallpaperData.fromMap(Map<String, dynamic> json) => WallpaperData(
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