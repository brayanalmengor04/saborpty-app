import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModelDetail.dart';
import 'package:saborpty_app/features/recipes/domain/repository/recipes_repository_impl.dart';
import 'package:saborpty_app/shared/widgets/tab/ingredients_tab.dart';
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
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _recipeDetailFuture = _repo.getRecipeDetailById(widget.recipeId);
    _tabController = TabController(length: 2, vsync: this);
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
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: NestedScrollView(
                    physics: const ClampingScrollPhysics(), 
                    headerSliverBuilder: (context, _) => [
                      SliverAppBar(
                        expandedHeight: 340,
                        pinned: true,
                        backgroundColor: AppColors.primary,
                        iconTheme: const IconThemeData(color: Colors.white),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(recipe.imageUrl ?? '', fit: BoxFit.cover),
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                                child: Container(color: Colors.black.withOpacity(0.3)),
                              ),
                              Positioned(
                                top: 16,
                                right: 16,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isFavorite ? Colors.red : Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 80,
                                left: 20,
                                right: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: 8,
                                      children: [
                                        _buildOverlayLabel(recipe.categoryName ?? 'Uknown'),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(recipe.title ?? "",
                                        style: const TextStyle(
                                            fontSize: 26,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 6),
                                    Text(recipe.description ?? "",
                                        style:
                                            const TextStyle(color: Colors.white70, fontSize: 14)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                    body: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding:
                              const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 4))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildInfoCard(
                                  FontAwesomeIcons.clock, "Tiempo", "${recipe.durationMinutes} min"),
                              _buildInfoCard(FontAwesomeIcons.fire, "Dificultad",
                                  recipe.difficulty ?? "Media"),
                              _buildInfoCard(
                                  FontAwesomeIcons.star, "Rating", recipe.rating.toString()),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [Colors.redAccent, Colors.deepOrange],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.redAccent,
                                  blurRadius: 10,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Acción del botón YouTube
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.play_circle_fill,
                                      size: 28, color: Colors.white),
                                  SizedBox(width: 12),
                                  Text(
                                    "Ver Tutorial en YouTube",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTabBar(tabController: _tabController),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              IngredientsTab(ingredients: ingredients),
                              StepsTab(steps: steps),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Column(
      children: [
        FaIcon(icon, color: AppColors.textSecondary, size: 28),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        Text(value, style: const TextStyle(fontSize: 13, color: Colors.black87)),
      ],
    );
  }
}
