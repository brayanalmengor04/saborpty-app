import 'dart:convert';

RecipeModelDetail recipeModelDetailFromJson(String str) => RecipeModelDetail.fromJson(json.decode(str));

String recipeModelDetailToJson(RecipeModelDetail data) => json.encode(data.toJson());

class RecipeModelDetail {
  Recipe? recipe;
  List<Ingredient>? ingredients;

  RecipeModelDetail({
    this.recipe,
    this.ingredients,
  });

  factory RecipeModelDetail.fromJson(Map<String, dynamic> json) => RecipeModelDetail(
        recipe: json["recipe"] == null ? null : Recipe.fromJson(json["recipe"]),
        ingredients: json["ingredients"] == null
            ? null
            : List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recipe": recipe?.toJson(),
        "ingredients": ingredients == null
            ? null
            : List<dynamic>.from(ingredients!.map((x) => x.toJson())),
      };
}

class Ingredient {
  int? id;
  int? recipeId;
  String? name;
  String? iconUrl;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;

  Ingredient({
    this.id,
    this.recipeId,
    this.name,
    this.iconUrl,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        recipeId: json["recipe_id"],
        name: json["name"],
        iconUrl: json["icon_url"],
        note: json["note"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "recipe_id": recipeId,
        "name": name,
        "icon_url": iconUrl,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Recipe {
  int? id;
  String? title;
  String? description;
  int? durationMinutes;
  String? difficulty;
  double? rating;
  String? imageUrl;
  List<String>? steps;
  String? categoryName;

  Recipe({
    this.id,
    this.title,
    this.description,
    this.durationMinutes,
    this.difficulty,
    this.rating,
    this.imageUrl,
    this.steps,
    this.categoryName,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> stepsList = [];
    if (json["steps"] != null) {
      if (json["steps"] is String) {
        // Decodificar el string JSON para obtener la lista
        stepsList = List<String>.from(jsonDecode(json["steps"]));
      } else if (json["steps"] is List) {
        stepsList = List<String>.from(json["steps"]);
      }
    }

    return Recipe(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      durationMinutes: json["duration_minutes"],
      difficulty: json["difficulty"],
      rating: json["rating"] != null ? (json["rating"] as num).toDouble() : null,
      imageUrl: json["image_url"],
      steps: stepsList,
      categoryName: json["categoryName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "duration_minutes": durationMinutes,
        "difficulty": difficulty,
        "rating": rating,
        "image_url": imageUrl,
        "steps": steps,
        "categoryName": categoryName,
      };
}
