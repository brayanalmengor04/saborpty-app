
import 'package:flutter/material.dart';
import 'package:saborpty_app/features/favorites/domain/favorite_recipe.dart';

class FavoriteCard extends StatelessWidget {
  final FavoriteRecipe recipe;

  const FavoriteCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 25, backgroundColor: Colors.grey),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(recipe.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(recipe.category,
                          style: const TextStyle(color: Colors.grey))
                    ],
                  ),
                ),
                const Icon(Icons.favorite, color: Colors.red),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 4),
                Text('${recipe.timeMinutes} min'),
                const SizedBox(width: 16),
                const Icon(Icons.star, size: 16, color: Colors.amber),
                Text(recipe.rating.toString()),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: recipe.cooked ? Colors.green[100] : Colors.orange[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    recipe.cooked ? 'Cocinada' : 'Por cocinar',
                    style: TextStyle(
                        color: recipe.cooked ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  recipe.savedSince,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
