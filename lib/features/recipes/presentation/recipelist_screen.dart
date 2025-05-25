import 'package:flutter/material.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModel.dart';
import 'package:saborpty_app/features/recipes/domain/repository/recipes_repository_impl.dart';
import 'package:saborpty_app/shared/widgets/recipe_card.dart';

class RecipelistScreen extends StatefulWidget { 

  
  const RecipelistScreen({super.key});

  @override
  State<RecipelistScreen> createState() => _RecipelistScreenState();
}

class _RecipelistScreenState extends State<RecipelistScreen> {  
  
  final RecipesRepositoryImpl _repo = RecipesRepositoryImpl();
  List<RecipeModel> _recipes = [];
  int _visibleCount = 4;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    try {
      final data = await _repo.getAllRecipes();
      setState(() {
        _recipes = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(  left: 10,bottom: 5,),
            child: const Text(
              "Popular recipes",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 10),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_hasError)
            const Center(child: Text("Error al cargar recetas"))
          else
                ..._recipes.take(_visibleCount).map(
                  (recipe) => RecipeCard(
                    id: recipe.id ?? 0,
                    title: recipe.title ?? 'Unknown Error',
                    description: recipe.description ?? 'No description available',
                    categoryName: recipe.categoryName ?? 'Uncategorized',
                    durationMinutes: recipe.durationMinutes ?? 0,
                    difficulty: recipe.difficulty ?? 'Unknown',
                    rating: recipe.rating ?? 0.0,
                    imageUrl: recipe.imageUrl ?? '',
                  ),
                ),
          if (!_isLoading && !_hasError && _visibleCount < _recipes.length)
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _visibleCount += 4;
                  });
                },
                child: const Text("Ver más"),
              ),
            ),
        ],
      ),
    );
  }
}