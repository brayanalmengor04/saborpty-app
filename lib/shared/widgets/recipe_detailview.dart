import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModelDetail.dart';
import 'package:saborpty_app/features/recipes/domain/repository/recipes_repository_impl.dart';
import 'package:saborpty_app/shared/widgets/tab/ingredients_tab.dart';
import 'package:saborpty_app/shared/widgets/tab/presentation_tab.dart';
import 'package:saborpty_app/shared/widgets/tab/steps_tab.dart';
import 'package:saborpty_app/shared/widgets/tab_bar.dart';

class RecipeDetailview extends StatefulWidget {
  final int recipeId;

  const RecipeDetailview({super.key, required this.recipeId});

  @override
  State<RecipeDetailview> createState() => _RecipeDetailviewState();
}

class _RecipeDetailviewState extends State<RecipeDetailview> with TickerProviderStateMixin {
  final RecipesRepositoryImpl _repo = RecipesRepositoryImpl();
  late Future<RecipeModelDetail> _recipeDetailFuture;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _recipeDetailFuture = _repo.getRecipeDetailById(widget.recipeId);
    _tabController = TabController(length: 3, vsync: this);
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
        final steps = recipe.steps ?? [];

        return Scaffold(
          backgroundColor: AppColors.background,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: AppColors.primary,
                iconTheme: const IconThemeData(color: AppColors.secondary),
                flexibleSpace: FlexibleSpaceBar(
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
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              
                              _buildOverlayLabel('${recipe.rating}'),
                              const SizedBox(width: 10),
                              if (recipe.categoryName != null)
                                _buildOverlayLabel(recipe.categoryName!),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.background
                    ),
                    child: CustomTabBar(tabController: _tabController)
                  ),
                ),
              ),
            ],
            body:TabBarView(   
            controller: _tabController,
            children: [
              PresentationTab(recipe: recipe),
              IngredientsTab(ingredients: ingredients),
              StepsTab(steps: steps),
            ],
          ),
          ),
        );
      },
    );
  }
  Widget _buildOverlayLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.shawdowCard.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: 
      Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
