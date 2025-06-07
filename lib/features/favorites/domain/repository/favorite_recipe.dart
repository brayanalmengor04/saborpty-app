
import 'package:saborpty_app/features/favorites/data/models/favorite_recipe_model.dart';

abstract class FavoriteRecipeRepository {
  Future<bool> addFavorite(String firebaseUid, int recipeId);
  Future<List<FavoriteRecipeModel>> getFavoritesByUser(String firebaseUid);
  Future<bool> deleteFavorite(String firebaseUid, int recipeId);
}
