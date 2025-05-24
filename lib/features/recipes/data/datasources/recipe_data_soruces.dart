import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saborpty_app/features/recipes/data/models/RecipeModel.dart';

class RecipeDataSoruces {

  final String baseUrl ="https://saborpty-backend-production.up.railway.app/api/v1/recipes/enriched/all";

  Future <List<RecipeModel>> getRecipes() async {
     final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar las recetas');
    }
  }
}