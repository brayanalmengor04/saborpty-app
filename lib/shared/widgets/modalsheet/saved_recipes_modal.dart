import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saborpty_app/features/favorites/data/datasources/favorite_data_source.dart';
import 'package:saborpty_app/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:saborpty_app/features/favorites/domain/repository/favorite_recipe_impl.dart';
import 'package:saborpty_app/shared/widgets/grid_recipe_card.dart';
import 'package:saborpty_app/shared/widgets/modalsheet/widget/filter_chip_list.dart';
import 'package:saborpty_app/shared/widgets/modalsheet/widget/stat_box.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

void showSavedRecipesModal(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;
  final _repo = FavoriteRecipeRepositoryImpl(
    dataSource: FavoriteDataSource(client: http.Client()),
  );
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return DraggableScrollableSheet(
        initialChildSize: 0.60,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return FutureBuilder<List<FavoriteRecipeModel>>(
            future: _repo.getFavoritesByUser(user.uid),
            builder: (context, snapshot) {
           
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final favorites = snapshot.data ?? [];
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Text(
                      'Recetas Guardadas',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const FilterChipList(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        StatBox(
                          color: Colors.orange,
                          label: 'Total',
                          value: favorites.length.toString(),
                        ),
                        const SizedBox(width: 12),
                        StatBox(
                          color: Colors.green,
                          label: 'Favoritas',
                          value: favorites.length.toString(),
                        ),
                        const SizedBox(width: 12),
                        const StatBox(
                          color: Colors.blue,
                          label: 'Cocinadas',
                          value: '0',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// 💡 Sorpresa visual si no hay recetas
                    if (favorites.isEmpty)
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/lottie/nodata.json', 
                                height: 180,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                '¡Aún no has guardado recetas!',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Podrías navegar al explorador de recetas
                                  // Navigator.pushNamed(context, '/recipes');
                                },
                                child: const Text('Explorar Recetas'),
                              ),
                            ],
                          ),
                        ),
                      ),

                    /// 🎯 Lista si hay favoritos
                    if (favorites.isNotEmpty)
                      Expanded(
                        child: GridView.builder(
                          controller: scrollController,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 3 / 4,
                          ),
                          itemCount: favorites.length,
                          itemBuilder: (context, index) {
                            final recipe = favorites[index].recipe!;
                            return GridRecipeCard(
                              id: recipe.id ?? 0,
                              title: recipe.title ?? "Sin título",
                              difficulty: recipe.difficulty ?? "Media",
                              durationMinutes: recipe.durationMinutes ?? 45,
                              rating: recipe.rating ?? 0.0,
                              imageUrl: recipe.imageUrl ??
                                  "https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg",
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}
