
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
        recipe: Recipe.fromJson(json["recipe"]),
        ingredients: List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "recipe": recipe?.toJson(),
        "ingredients": List<dynamic>.from(ingredients!.map((x) => x.toJson())),
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "recipe_id": recipeId,
        "name": name,
        "icon_url": iconUrl,
        "note": note,
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

    factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        durationMinutes: json["duration_minutes"],
        difficulty: json["difficulty"],
        rating: json["rating"].toDouble(),
        imageUrl: json["image_url"],
        steps: List<String>.from(json["steps"].map((x) => x)),
        categoryName: json["category_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "duration_minutes": durationMinutes,
        "difficulty": difficulty,
        "rating": rating,
        "image_url": imageUrl,
        "steps": List<dynamic>.from(steps!.map((x) => x)),
        "category_name": categoryName,
    };
}
