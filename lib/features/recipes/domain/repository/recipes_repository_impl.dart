import 'package:saborpty_app/features/recipes/data/datasources/recipe_data_soruces.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModel.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModelDetail.dart';
import 'package:saborpty_app/features/recipes/domain/repository/recipes_repository.dart';

class RecipesRepositoryImpl implements RecipesRepository{
  
  final RecipeDataSoruces dataSources = RecipeDataSoruces();

  @override
  Future<List<RecipeModel>> getAllRecipes() => dataSources.getRecipes();

  @override
  Future<RecipeModelDetail> getRecipeDetailById(int id) => dataSources.getRecipeDetailById(id);
  
  @override
  Future<List<RecipeModel>> getAllRecipesByCategory(String categoryName) => dataSources.getRecipeByCategory(categoryName);
  
  @override
  Future<List<RecipeModel>> getAllRecipesFilterPreparation(String categoryName) {
   return dataSources.getRecipeFilterPreparation(categoryName);
  }
  
  @override
  Future<List<RecipeModel>> getAllRecipesFilterRating(String categoryName) {
   return dataSources.getRecipeFilterRating(categoryName);
  }
  
  @override
  Future<List<RecipeModel>> getAllRecipesFilterRecent(String categoryName) {
   return dataSources.getRecipeFilterRecent(categoryName);
  }
  
}