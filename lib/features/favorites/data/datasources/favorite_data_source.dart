import 'package:http/http.dart' as http;
import 'package:saborpty_app/core/constants/api_routes.dart';
import 'dart:convert';
import '../models/favorite_recipe_model.dart';

class FavoriteDataSource {
  final http.Client client;

  FavoriteDataSource({required this.client});

  Future<bool> addFavorite(String firebaseUid, int recipeId) async {
    final response = await client.post(
      Uri.parse(ApiRoutes.pathAddFavorite()),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "firebase_uid": firebaseUid,
        "recipe_id": recipeId,
      }),
    );

    return response.statusCode == 201;
  }

  Future<List<FavoriteRecipeModel>> getFavoritesByUser(String firebaseUid) async {
    final response = await client.get(Uri.parse(ApiRoutes.pathGetFavoriteByUser(firebaseUid)));

    if (response.statusCode == 200) {
      final List<dynamic> decoded = json.decode(response.body);
      return decoded.map((json) => FavoriteRecipeModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load favorites");
    }
  }

  Future<bool> deleteFavorite(String firebaseUid, int recipeId) async {
    final response = await client.delete(
      Uri.parse(ApiRoutes.pathDeleteFavoriteByUser(firebaseUid, recipeId)),
    );
    return response.statusCode == 200;
  }
}
