// To parse this JSON data, do
//
//     final recipeModel = recipeModelFromJson(jsonString);

import 'dart:convert';

RecipeModel recipeModelFromJson(String str) => RecipeModel.fromJson(json.decode(str));

String recipeModelToJson(RecipeModel data) => json.encode(data.toJson());

class RecipeModel {
    int? id;
    String? title;
    String? description;
    String? categoryName;
    int? durationMinutes;
    String? difficulty;
    double? rating;
    String? imageUrl;

    RecipeModel({
        this.id,
        this.title,
        this.description,
        this.categoryName,
        this.durationMinutes,
        this.difficulty,
        this.rating,
        this.imageUrl,
    });

    factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        categoryName: json["categoryName"],
        durationMinutes: json["durationMinutes"],
        difficulty: json["difficulty"],
        rating: json["rating"].toDouble(),
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "categoryName": categoryName,
        "durationMinutes": durationMinutes,
        "difficulty": difficulty,
        "rating": rating,
        "imageUrl": imageUrl,
    };
}
