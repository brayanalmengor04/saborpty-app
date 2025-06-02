import 'package:saborpty_app/features/recipes/data/models/RecipeModel.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModelDetail.dart';

abstract class RecipesRepository {
  Future <List<RecipeModel>> getAllRecipes(); 
  Future <RecipeModelDetail> getRecipeDetailById(int id);
  Future <List<RecipeModel>> getAllRecipesByCategory(String categoryName);
  Future <List<RecipeModel>> getAllRecipesFilterPreparation(String categoryName);
  Future <List<RecipeModel>> getAllRecipesFilterRating(String categoryName);
  Future <List<RecipeModel>> getAllRecipesFilterRecent(String categoryName);
}