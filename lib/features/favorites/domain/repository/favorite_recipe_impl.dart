import 'package:saborpty_app/features/favorites/data/datasources/favorite_data_source.dart';
import 'package:saborpty_app/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:saborpty_app/features/favorites/domain/repository/favorite_recipe.dart';

class FavoriteRecipeRepositoryImpl implements FavoriteRecipeRepository {
  final FavoriteDataSource dataSource;

  FavoriteRecipeRepositoryImpl({required this.dataSource});

  @override
  Future<bool> addFavorite(String firebaseUid, int recipeId) {
    return dataSource.addFavorite(firebaseUid, recipeId);
  }

  @override
  Future<List<FavoriteRecipeModel>> getFavoritesByUser(String firebaseUid) {
    return dataSource.getFavoritesByUser(firebaseUid);
  }

  @override
  Future<bool> deleteFavorite(String firebaseUid, int recipeId) {
    return dataSource.deleteFavorite(firebaseUid, recipeId);
  }
}
