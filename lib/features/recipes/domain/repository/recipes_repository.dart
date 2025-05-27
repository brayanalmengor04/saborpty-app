import 'package:saborpty_app/features/recipes/data/models/RecipeModel.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModelDetail.dart';

abstract class RecipesRepository {
  Future <List<RecipeModel>> getAllRecipes(); 
  Future <RecipeModelDetail> getRecipeDetailById(int id);
}