import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saborpty_app/core/constants/api_routes.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModel.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModelDetail.dart';

class RecipeDataSoruces {
  Future<void> rateRecipe({required int recipeId,
  required String uid,
  required double rating,}) async {
  final url = Uri.parse(ApiRoutes.pathRatingRecipe(recipeId));
  final body = jsonEncode({
    "uid": uid,
    "rating": rating,
  });
  final headers = {'Content-Type': 'application/json'};
  final response = await http.put(url, body: body, headers: headers);
  if (response.statusCode != 200) {
    throw Exception('Failed to rate recipe. Backend responded with: ${response.statusCode}');
  }
}
  Future <List<RecipeModel>> getRecipes() async {
     final response = await http.get(Uri.parse(ApiRoutes.pathGetAllRecipes));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception('Error loading recipes backend');
    }
  }  
  Future<RecipeModelDetail> getRecipeDetailById(int id) async {
    final response = await http.get(Uri.parse(ApiRoutes.pathGetDetailRecipes(id)));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return RecipeModelDetail.fromJson(data);
    } else {
      throw Exception('Error loading recipe detail from backend');
    }
  } 

  Future<List<RecipeModel>> getRecipeByCategory(String categoryName) async {
   final response = await http.get(Uri.parse(ApiRoutes.pathGetAllRecipesByCategory(categoryName))); 
      if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception('Error loading recipes by cateogry backend');
    }
  }

  Future<List<RecipeModel>> getRecipeFilterPreparation(String categoryName) async {
   final response = await http.get(Uri.parse(ApiRoutes.pathGetAllPreparationFilter(categoryName))); 
      if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception('Error loading recipes by preparation backend');
    }
  } 

  Future<List<RecipeModel>> getRecipeFilterRating(String categoryName) async {
   final response = await http.get(Uri.parse(ApiRoutes.pathGetAllRatingFilter(categoryName))); 
      if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception('Error loading recipes by cateogry backend');
    }
  }

    Future<List<RecipeModel>> getRecipeFilterRecent(String categoryName) async {
   final response = await http.get(Uri.parse(ApiRoutes.pathGetAllRecentFilter(categoryName))); 
      if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception('Error loading recipes by recent backend');
    }
  }

}