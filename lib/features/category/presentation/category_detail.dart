import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import 'package:saborpty_app/shared/widgets/grid_recipe_card.dart';
import 'package:saborpty_app/shared/widgets/recipe_card.dart';

class CategoryDetail extends StatefulWidget {
  const CategoryDetail({super.key});

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  bool isGrid = false;

  final List<Map<String, dynamic>> recipe = [
    {
      "id": 1,
      "title": "Sancocho Panameño",
      "description":
          "Una sopa tradicional panameña con pollo, ñame y vegetales frescos.",
      "durationMinutes": 45,
      "rating": 4.9,
      "difficulty": "Media",
      "imageUrl":
          "https://res.cloudinary.com/dv5ruetn7/image/upload/v1747621022/cld-sample-3.jpg"
    },
    {
      "id": 2,
      "title": "Sancocho Panameño",
      "description":
          "Una sopa tradicional panameña con pollo, ñame y vegetales frescos.",
      "durationMinutes": 45,
      "rating": 4.9,
      "difficulty": "Media",
      "imageUrl":
          "https://res.cloudinary.com/dv5ruetn7/image/upload/v1747621022/cld-sample-3.jpg"
    },
  ];



  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Sopas";
    const String categoryDescription =
        "Sopas tradicionales panameñas que calientan el alma";
    final String recipeCount = "${recipe.length} recetas disponibles";

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF6F2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5A3921)),
          onPressed: () => context.go(AppRoutes.home),
        ),
        title: const Text(
          "Sopas",
          style: TextStyle(
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
                child: const Icon(Icons.image, size: 60, color: Colors.white54),
              ),
              Positioned(
                bottom: 12,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryTitle,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5A3921),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      categoryDescription,
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
                        style: const TextStyle(color: Colors.white, fontSize: 12),
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
                DropdownButton<String>(
                  value: "Más populares",
                  items: const [
                    DropdownMenuItem(
                      value: "Más populares",
                      child: Text("Más populares"),
                    ),
                  ],
                  onChanged: (_) {},
                  underline: const SizedBox(),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: isGrid
                  ? GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      children: recipe
                          .map((r) => GridRecipeCard(
                                id: r["id"],
                                title: r["title"],
                                durationMinutes: r["durationMinutes"],
                                difficulty: r["difficulty"],
                                rating: r["rating"],
                                imageUrl: r["imageUrl"],
                              ))
                          .toList(),
                    )
                  : ListView(
                      children: recipe
                          .map((r) => RecipeCard(
                                id: r["id"],
                                title: r["title"],
                                description: r["description"],
                                categoryName: categoryTitle,
                                durationMinutes: r["durationMinutes"],
                                difficulty: r["difficulty"],
                                rating: r["rating"],
                                imageUrl: r["imageUrl"],
                              ))
                          .toList(),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
