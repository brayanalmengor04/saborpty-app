import 'package:saborpty_app/features/recipes/data/models/RecipeModel.dart';

abstract class RecipesRepository {
  Future <List<RecipeModel>> getAllRecipes();
}