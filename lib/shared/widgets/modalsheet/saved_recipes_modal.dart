import 'package:flutter/material.dart';
import 'package:saborpty_app/shared/widgets/grid_recipe_card.dart';
import 'package:saborpty_app/shared/widgets/modalsheet/widget/filter_chip_list.dart';
import 'package:saborpty_app/shared/widgets/modalsheet/widget/stat_box.dart';

void showSavedRecipesModal(BuildContext context) {
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
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Recetas Guardadas',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Filtros
                const FilterChipList(),
                const SizedBox(height: 16),

                // Stats
                Row(
                  children: const [
                    StatBox(
                      color: Colors.orange,
                      label: 'Total',
                      value: '18',
                    ),
                    SizedBox(width: 12),
                    StatBox(
                      color: Colors.green,
                      label: 'Favoritas',
                      value: '5',
                    ),
                    SizedBox(width: 12),
                    StatBox(
                      color: Colors.blue,
                      label: 'Cocinadas',
                      value: '7',
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Grid de recetas
                Expanded(
                  child: GridView.count(
                    controller: scrollController,
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 3 / 4,
                    children: const [
                      GridRecipeCard(
                        title: 'Arroz con Pollo', 
                        difficulty: "nose",
                        durationMinutes: 90,
                        rating: 4.00,
                        id: 1,
                        imageUrl: 'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                      ),
                     GridRecipeCard(
                        title: 'Arroz con Pollo', 
                        difficulty: "nose",
                        durationMinutes: 90,
                        rating: 4.00,
                        id: 1,
                        imageUrl: 'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                      ),
                      GridRecipeCard(
                        title: 'Arroz con Pollo', 
                        difficulty: "nose",
                        durationMinutes: 90,
                        rating: 4.00,
                        id: 1,
                        imageUrl: 'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                      ),
                      GridRecipeCard(
                        title: 'Arroz con Pollo', 
                        difficulty: "nose",
                        durationMinutes: 90,
                        rating: 4.00,
                        id: 1,
                        imageUrl: 'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                      ),
                        GridRecipeCard(
                        title: 'Arroz con Pollo', 
                        difficulty: "nose",
                        durationMinutes: 90,
                        rating: 4.00,
                        id: 1,
                        imageUrl: 'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                      ),
                        GridRecipeCard(
                        title: 'Arroz con Pollo', 
                        difficulty: "nose",
                        durationMinutes: 90,
                        rating: 4.00,
                        id: 1,
                        imageUrl: 'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                      ),
                        GridRecipeCard(
                        title: 'Arroz con Pollo', 
                        difficulty: "nose",
                        durationMinutes: 90,
                        rating: 4.00,
                        id: 1,
                        imageUrl: 'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                      ),
                        GridRecipeCard(
                        title: 'Arroz con Pollo', 
                        difficulty: "nose",
                        durationMinutes: 90,
                        rating: 4.00,
                        id: 1,
                        imageUrl: 'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
