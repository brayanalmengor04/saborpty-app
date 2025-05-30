import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModelDetail.dart';

class IngredientsTab extends StatelessWidget {
  final List<Ingredient> ingredients;

  const IngredientsTab({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text(
            "Ingredientes",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          ...ingredients.map((ingredient) => ListTile(
                leading: ingredient.iconUrl != null
                    ? Image.network(ingredient.iconUrl!, width: 40, height: 40)
                    : const Icon(Icons.kitchen, color: AppColors.secondary),
                title: Text(ingredient.name ?? ''),
                subtitle: Text(ingredient.note ?? ''),
              )),
        ],
      ),
    );
  }
}
