import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saborpty_app/core/constants/api_routes.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModel.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModelDetail.dart';

class RecipeDataSoruces {
 
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
}