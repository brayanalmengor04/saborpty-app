import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/features/favorites/data/datasources/favorite_data_source.dart';
import 'package:saborpty_app/features/favorites/domain/repository/favorite_recipe_impl.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModelDetail.dart';
import 'package:saborpty_app/features/recipes/domain/repository/recipes_repository_impl.dart';
import 'package:saborpty_app/shared/navegation/app_router.dart';
import 'package:saborpty_app/shared/widgets/rating/rating_section.dart';
import 'package:saborpty_app/shared/widgets/tab/ingredients_tab.dart';
import 'package:saborpty_app/shared/widgets/tab/steps_tab.dart';
import 'package:saborpty_app/shared/widgets/tab_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class RecipeDetailview extends StatefulWidget {
  final int recipeId; 
  final User? user;

  const RecipeDetailview({
    super.key,
    required this.recipeId,
    required this.user, 
  });

  @override
  State<RecipeDetailview> createState() => _RecipeDetailviewState();
}

class _RecipeDetailviewState extends State<RecipeDetailview>
    with TickerProviderStateMixin {
  final RecipesRepositoryImpl _repo = RecipesRepositoryImpl();
  late Future<RecipeModelDetail> _recipeDetailFuture;
  final _favoriteRepo = FavoriteRecipeRepositoryImpl(
    dataSource: FavoriteDataSource(client: http.Client()),
  );
  final ValueNotifier<bool> isFavoriteNotifier = ValueNotifier(false);
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _recipeDetailFuture = _repo.getRecipeDetailById(widget.recipeId);
    _tabController = TabController(length: 2, vsync: this);
    _loadFavoriteState();
  }

  /// Carga inicial del estado de favorito
  Future<void> _loadFavoriteState() async {
    if (widget.user == null) return;
    final favs = await _favoriteRepo.getFavoritesByUser(widget.user!.uid);
    final exists = favs.any((f) => f.recipeId == widget.recipeId);
    isFavoriteNotifier.value = exists;
  }

  /// Refresca el detalle y vuelve a chequear favorito
  void _refreshData() {
    setState(() {
      _recipeDetailFuture = _repo.getRecipeDetailById(widget.recipeId);
    });
    _loadFavoriteState();
  }

  Future<void> _toggleFavorite() async {
    if (widget.user == null) return;

    final uid = widget.user!.uid;
    final currentlyFav = isFavoriteNotifier.value;

    if (!currentlyFav) {
      // Agregar favorito
      final success = await _favoriteRepo.addFavorite(uid, widget.recipeId);
      if (success) {
        isFavoriteNotifier.value = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Receta guardada como favorita")),
        );
      }
    } else {
      // Confirmar y eliminar
      final confirmed = await _showConfirmationDialog();
      if (confirmed) {
        final success = await _favoriteRepo.deleteFavorite(uid, widget.recipeId);
        if (success) {
          isFavoriteNotifier.value = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Receta eliminada de favoritos")),
          );
        }
      }
    }
    // Actualizar datos e ícono
    _refreshData();
  }

  Future<bool> _showConfirmationDialog() async {
    return (await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("¿Eliminar de favoritos?"),
            content: const Text(
                "¿Estás seguro de que quieres eliminar esta receta de tus favoritos?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent),
                child: const Text("Sí, eliminar"),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RecipeModelDetail>(
      future: _recipeDetailFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child:
                  CircularProgressIndicator(color: AppColors.textSecondary),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('No recipe found.')),
          );
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
                        iconTheme:
                            const IconThemeData(color: Colors.white),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(recipe.imageUrl ?? '',
                                  fit: BoxFit.cover),
                              BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 2.0, sigmaY: 2.0),
                                child: Container(
                                    color:
                                        Colors.black.withOpacity(0.3)),
                              ),
                              // Botón favorito
                              Positioned(
                                top: 16,
                                right: 16,
                                child: ValueListenableBuilder<bool>(
                                  valueListenable: isFavoriteNotifier,
                                  builder: (context, isFav, _) {
                                    return GestureDetector(
                                      onTap: _toggleFavorite,
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                            milliseconds: 300),
                                        decoration: BoxDecoration(
                                          color: isFav
                                              ? Colors.redAccent
                                              : Colors.black.withOpacity(0.6),
                                          shape: BoxShape.circle,
                                        ),
                                        padding:
                                            const EdgeInsets.all(8),
                                        child: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons
                                                  .favorite_border,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Texto sobre la imagen
                              Positioned(
                                bottom: 80,
                                left: 20,
                                right: 20,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: 8,
                                      children: [
                                        _buildOverlayLabel(
                                            recipe.categoryName ??
                                                'Unknown'),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(recipe.title ?? "",
                                        style: const TextStyle(
                                            fontSize: 26,
                                            color: Colors.white,
                                            fontWeight:
                                                FontWeight.bold)),
                                    const SizedBox(height: 6),
                                    Text(recipe.description ?? "",
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14)),
                                    
                                  ],
                                ),
                              ), 
                              Positioned(
                                bottom: 25,
                                left: 20,
                                right: 20,
                                child:Column( 
                                  children: [
                                   RatingSection(initialRating: recipe.rating ?? 0.00,
                                       recipeId: recipe.id ?? 0,
                                      firebaseUid: user!.uid,
                                      onConfirmedRating:(rating) async {
                                          // lógica del backend
                                          // await RecipeRepositoryImpl().rateRecipe(
                                          //   recipeId: recipe.id!,
                                          //   uid: user!.uid,
                                          //   rating: rating, 
                                          print(rating);
                                          // );
                                        },
                                    ),
                                  ]
                                ) 
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    body: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Tarjetas de info
                        Container(
                          margin:
                              const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 4))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [
                              _buildInfoCard(FontAwesomeIcons.clock,
                                  "Tiempo", "${recipe.durationMinutes} min"),
                              _buildInfoCard(FontAwesomeIcons.fire,
                                  "Dificultad", recipe.difficulty ?? "Media"),
                              _buildInfoCard(FontAwesomeIcons.star,
                                  "Rating", recipe.rating.toString()),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16), 
                        // Botón YouTube
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.redAccent,
                                  Colors.deepOrange
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.redAccent,
                                  blurRadius: 10,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () async{  
                                // Lo ideal seria poner un un reproductor despues lo agrego
                                  await launchUrl(Uri.parse(recipe.youtubeUrl!), mode: LaunchMode.externalApplication);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(16)),
                                padding:
                                    const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
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
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text,
          style:
              const TextStyle(color: Colors.white, fontSize: 13)),
    );
  }
  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Column(
      children: [
        FaIcon(icon, color: AppColors.textSecondary, size: 28),
        const SizedBox(height: 4),
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 13)),
        Text(value,
            style: const TextStyle(
                fontSize: 13, color: Colors.black87)),
      ],
    );
  }
}
