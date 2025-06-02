import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModel.dart';
import 'package:saborpty_app/features/recipes/domain/repository/recipes_repository_impl.dart';
import 'package:saborpty_app/shared/widgets/grid_recipe_card.dart';
import 'package:saborpty_app/shared/widgets/recipe_card.dart';
import 'package:saborpty_app/shared/widgets/shimmer/shimmer_recipe_card.dart';

class CategoryDetail extends StatefulWidget {
  final String categoryName;
  final String categoryImage;

  const CategoryDetail({
    super.key,
    required this.categoryName,
    required this.categoryImage,
  });

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}
class _CategoryDetailState extends State<CategoryDetail> {
  final RecipesRepositoryImpl _repo = RecipesRepositoryImpl();
  bool isGrid = false;
  List<RecipeModel> _recipes = [];
  bool _isLoading = true;
  String _selectedFilter = "Todas";
  final List<String> _filterOptions = [
    "Todas",
    "Más recientes",
    "Más populares",
    "Tiempo de preparación"
  ];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    setState(() => _isLoading = true);
    try {
      List<RecipeModel> data;
      switch (_selectedFilter) {
        case "Más recientes":
          data = await _repo.getAllRecipesFilterRecent(widget.categoryName);
          break;
        case "Más populares":
          data = await _repo.getAllRecipesFilterRating(widget.categoryName);
          break;
        case "Tiempo de preparación":
          data = await _repo.getAllRecipesFilterPreparation(widget.categoryName);
          break;
        default:
          data = await _repo.getAllRecipesByCategory(widget.categoryName);
      }
      setState(() {
        _recipes = data;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => _isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    final String recipeCount = "${_recipes.length} recetas disponibles";

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6F2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5A3921)),
          onPressed: () => context.go(AppRoutes.home),
        ),
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            color: Color(0xFF5A3921),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade100, Colors.orange.shade200],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Image.network(
                  widget.categoryImage,
                  fit: BoxFit.cover,
                  width: 140,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image, size: 60, color: Colors.white54),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipeCount,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5A3921),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Descripción de la categoría",
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        recipeCount,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Buscar en esta categoría...",
                      hintStyle: const TextStyle(fontSize: 14),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.orange.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  color: Colors.deepOrange,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange.shade100),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedFilter,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.deepOrange),
                        dropdownColor: Colors.white,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5A3921),
                          fontWeight: FontWeight.w500,
                        ),
                        items: _filterOptions
                            .map((filter) => DropdownMenuItem<String>(
                                  value: filter,
                                  child: Text(filter),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedFilter = value;
                            });
                            _loadRecipes();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.view_list),
                  onPressed: () => setState(() => isGrid = false),
                ),
                IconButton(
                  icon: const Icon(Icons.grid_view_rounded),
                  onPressed: () => setState(() => isGrid = true),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadRecipes,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: _isLoading
                    ? (isGrid
                        ? GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            children: List.generate(
                              6,
                              (index) => const ShimmerRecipeCard(),
                            ),
                          )
                        : ListView(
                            children: List.generate(
                              6,
                              (index) => const ShimmerRecipeCard(),
                            ),
                          ))
                    : _recipes.isEmpty
                        ? const Center(
                            child: Text(
                              "No se encontraron recetas.",
                              style: TextStyle(color: Colors.black54),
                            ),
                          )
                        : isGrid
                            ? GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                children: _recipes
                                    .map((r) => GridRecipeCard(
                                          id: r.id ?? 0,
                                          title: r.title ?? 'No title',
                                          durationMinutes:
                                              r.durationMinutes ?? 0,
                                          difficulty: r.difficulty ?? 'Uknown',
                                          rating: r.rating ?? 0.00,
                                          imageUrl: r.imageUrl ??
                                              'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                                        ))
                                    .toList(),
                              )
                            : ListView(
                                children: _recipes
                                    .map((r) => RecipeCard(
                                          id: r.id ?? 0,
                                          title: r.title ?? 'No Title',
                                          description:
                                              r.description ?? 'No Description',
                                          categoryName:
                                              r.categoryName ?? 'No Category ',
                                          durationMinutes:
                                              r.durationMinutes ?? 0,
                                          difficulty: r.difficulty ?? 'Uknown',
                                          rating: r.rating ?? 0.00,
                                          imageUrl: r.imageUrl ??
                                              'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                                        ))
                                    .toList(),
                              ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
