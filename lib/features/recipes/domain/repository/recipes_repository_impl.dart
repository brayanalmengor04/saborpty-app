import 'package:saborpty_app/features/recipes/data/datasources/recipe_data_soruces.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModel.dart';
import 'package:saborpty_app/features/recipes/domain/repository/recipes_repository.dart';

class RecipesRepositoryImpl implements RecipesRepository{
  
  final RecipeDataSoruces dataSources = RecipeDataSoruces();

  @override
  Future<List<RecipeModel>> getAllRecipes() => dataSources.getRecipes();
  
}