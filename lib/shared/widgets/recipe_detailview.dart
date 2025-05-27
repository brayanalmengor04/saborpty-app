import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModelDetail.dart';
import 'package:saborpty_app/features/recipes/domain/repository/recipes_repository_impl.dart';

class RecipeDetailview extends StatefulWidget {
  final int recipeId;

  const RecipeDetailview({super.key, required this.recipeId});

  @override
  State<RecipeDetailview> createState() => _RecipeDetailviewState();
}

class _RecipeDetailviewState extends State<RecipeDetailview> {
  final RecipesRepositoryImpl _repo = RecipesRepositoryImpl();
  late Future<RecipeModelDetail> _recipeDetailFuture;

  @override
  void initState() {
    super.initState();
    _recipeDetailFuture = _repo.getRecipeDetailById(widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RecipeModelDetail>(
      future: _recipeDetailFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(color: AppColors.textSecondary)),
          );
        } else if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(body: Center(child: Text('No recipe found.')));
        }

        final recipe = snapshot.data!.recipe!;
        final ingredients = snapshot.data!.ingredients ?? [];

        return Scaffold(
          backgroundColor: AppColors.background,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: AppColors.primary,
                iconTheme: const IconThemeData(color: AppColors.secondary),
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    final double top = constraints.biggest.height;
                    final bool isCollapsed = top <= kToolbarHeight + MediaQuery.of(context).padding.top + 10;
                   return FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.only(bottom: 16, right: 16),
                      title: AnimatedPadding(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.only(left: isCollapsed ? 72 : 16),
                        child: Text(
                          recipe.title ?? 'Sin título',
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            recipe.imageUrl ?? '',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0x00A7A6A6), AppColors.background],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 50,
                            left: 16,
                            child: Row(
                              children: [
                                _buildOverlayLabel('⭐ ${recipe.rating}'),
                                const SizedBox(width: 10),
                                if (recipe.categoryName != null)
                                  _buildOverlayLabel(recipe.categoryName!),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (recipe.description != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            recipe.description!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          _buildChip('Duración: ${recipe.durationMinutes} min'),
                          _buildChip('Dificultad: ${recipe.difficulty}'),
                        ],
                      ),
                      const SizedBox(height: 28),
                      _buildSectionTitle(' Ingredientes'),
                      const SizedBox(height: 8),
                      ...ingredients.map(
                        (ingredient) => ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: ingredient.iconUrl != null
                              ? Image.network(
                                  ingredient.iconUrl!,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
                                )
                              : const Icon(Icons.kitchen, color: AppColors.secondary),
                          title: Text(ingredient.name ?? 'Ingrediente'),
                          subtitle: Text(ingredient.note ?? ''),
                        ),
                      ),
                      const SizedBox(height: 28),
                      _buildSectionTitle('Pasos para preparar'),
                      const SizedBox(height: 8),
                      ...recipe.steps!.asMap().entries.map(
                        (e) => _buildStepTile(e.key + 1, e.value),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      backgroundColor: AppColors.borderRadius,
      label: Text(label, style: const TextStyle(color: AppColors.textSecondary)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildOverlayLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.shawdowCard.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStepTile(int number, String step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.startColor,
            child: Text(
              '$number',
              style: const TextStyle(color: AppColors.secondary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              step,
              style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textSecondary,
      ),
    );
  }
}
