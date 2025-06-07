// To parse this JSON data, do
//
//     final favoriteRecipeModel = favoriteRecipeModelFromJson(jsonString);

import 'dart:convert';

List<FavoriteRecipeModel> favoriteRecipeModelFromJson(String str) => List<FavoriteRecipeModel>.from(json.decode(str).map((x) => FavoriteRecipeModel.fromJson(x)));

String favoriteRecipeModelToJson(List<FavoriteRecipeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavoriteRecipeModel {
    int? id;
    String? firebaseUid;
    int? recipeId;
    DateTime? createdAt;
    DateTime? updatedAt;
    Recipe? recipe;

    FavoriteRecipeModel({
        this.id,
        this.firebaseUid,
        this.recipeId,
        this.createdAt,
        this.updatedAt,
        this.recipe,
    });

    factory FavoriteRecipeModel.fromJson(Map<String, dynamic> json) => FavoriteRecipeModel(
        id: json["id"],
        firebaseUid: json["firebase_uid"],
        recipeId: json["recipe_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        recipe: Recipe.fromJson(json["recipe"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firebase_uid": firebaseUid,
        "recipe_id": recipeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "recipe": recipe?.toJson(),
    };
}
class Recipe {
  int? id;
  String? title;
  double? rating;
  String? imageUrl;
  int? categoryId;
  String? difficulty;
  int? durationMinutes;
  DateTime? createdAt;
  DateTime? updatedAt;

  Recipe({
    this.id,
    this.title,
    this.rating,
    this.imageUrl,
    this.categoryId,
    this.difficulty,
    this.durationMinutes,
    this.createdAt,
    this.updatedAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        title: json["title"],
        rating: json["rating"]?.toDouble(),
        imageUrl: json["image_url"],
        categoryId: json["category_id"],
        difficulty: json["difficulty"],
        durationMinutes: json["duration_minutes"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "rating": rating,
        "image_url": imageUrl,
        "category_id": categoryId,
        "difficulty": difficulty,
        "duration_minutes": durationMinutes,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}


