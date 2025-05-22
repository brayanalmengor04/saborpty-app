
import 'dart:convert';
CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));
String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    int? id;
    String? name;
    String? slug;
    String? imageUrl;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;

    CategoryModel({
        this.id,
        this.name,
        this.slug,
        this.imageUrl,
        this.description,
        this.createdAt,
        this.updatedAt,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        imageUrl: json["image_url"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image_url": imageUrl,
        "description": description,
        if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
        if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
}
