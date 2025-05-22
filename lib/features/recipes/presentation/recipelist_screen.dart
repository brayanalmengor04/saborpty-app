import 'package:flutter/material.dart';
import 'package:saborpty_app/shared/widgets/recipe_card.dart';

class RecipelistScreen extends StatefulWidget { 

  
  const RecipelistScreen({super.key});

  @override
  State<RecipelistScreen> createState() => _RecipelistScreenState();
}

class _RecipelistScreenState extends State<RecipelistScreen> { 

   final List<Map<String, dynamic>> popularRecipes = [
    {
      "id": 1,
      "title": "Arroz con Pollo",
      "description": "Tradicionales",
      "categoryName": "Tradicionales",
      "durationMinutes": 45,
      "difficulty": "Media",
      "rating": 4.8,
      "imageUrl": "https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg"
    },
    {
      "id": 2,
      "title": "Patacones",
      "description": "Platos Rápidos",
      "categoryName": "Platos Rápidos",
      "durationMinutes": 20,
      "difficulty": "Fácil",
      "rating": 4.7,
      "imageUrl": "https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg"
    },
    {
      "id": 3,
      "title": "Ceviche Panameño",
      "description": "Mariscos",
      "categoryName": "Mariscos",
      "durationMinutes": 30,
      "difficulty": "Media",
      "rating": 4.9,
      "imageUrl": "https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg"
    },
  ];
  
    @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 20),
            child: Text(
              "Recetas Populares",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          ...popularRecipes.map((recipe) => RecipeCard(
                id: recipe['id'],
                title: recipe['title'],
                description: recipe['description'],
                categoryName: recipe['categoryName'],
                durationMinutes: recipe['durationMinutes'],
                difficulty: recipe['difficulty'],
                rating: recipe['rating'],
                imageUrl: recipe['imageUrl'],
              )),
        ],
      ),
    );
  }
}