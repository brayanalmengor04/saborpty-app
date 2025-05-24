import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget { 
  final int id ; 
  final String title ;   
  final String description; 
  final String categoryName ;  
  final int durationMinutes; 
  final String difficulty; 
  final double rating;  
  final String imageUrl;  

  const RecipeCard({super.key, 
  required this.id, required this.title, required this.description, required this.categoryName, 
  required this.durationMinutes, required this.difficulty, required this.rating, 
  required this.imageUrl});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}
class _RecipeCardState extends State<RecipeCard> { 
  void onRecipeTap(int id) { 
    // Realizar navegacion y mostrar detalle  pasando los datos a la otra vista .  

    // RecipeDetail (id: widget.id)
    print('Recipe tapped with id: $id');
    // Navigator.push(...) o showDialog(...) por ejemplo
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile( 
        onTap: () => onRecipeTap(widget.id), 
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(widget.description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${widget.durationMinutes} min',
                style: const TextStyle(color: Colors.orange),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                Text(widget.rating.toStringAsFixed(1)),
              ],
            )
          ],
        ),
      ),
    );
  }
}