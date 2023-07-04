import 'dart:convert';

class WallpaperModel {
  String? id;
  String? title;
  String? url;
  String? category;
  List<dynamic>? tags;
  bool? premium;

  WallpaperModel({
    this.id,
    this.title,
    this.url,
    this.category,
    this.tags,
    this.premium,
  });

  factory WallpaperModel.fromJson(String str) => WallpaperModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WallpaperModel.fromMap(Map<String, dynamic> json) => WallpaperModel(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    category: json["category"],
    tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
    premium: json["premium"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "url": url,
    "category": category,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "premium": premium,
  };
}
